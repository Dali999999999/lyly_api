import requests
import logging
from django.conf import settings
from rest_framework.exceptions import ValidationError

logger = logging.getLogger(__name__)

def verify_kkiapay_transaction(transaction_id):
    """
    Verifies a transaction status with Kkiapay API.
    Returns the transaction data if successful, or raises ValidationError.
    """
    if not transaction_id:
        raise ValidationError("Transaction ID is required.")

    # Determine Environment and URL
    is_sandbox = getattr(settings, 'KKIAPAY_SANDBOX', True)
    if isinstance(is_sandbox, str):
        is_sandbox = is_sandbox.lower() == 'true'
        
    base_url = "https://api-sandbox.kkiapay.me" if is_sandbox else "https://api.kkiapay.me"
    verify_url = f"{base_url}/api/v1/transactions/status"
    
    # Select API Key
    kkiapay_key = getattr(settings, 'KKIAPAY_PUBLIC_KEY', None)
    if not kkiapay_key:
            kkiapay_key = getattr(settings, 'KKIAPAY_PRIVATE_KEY', None) or getattr(settings, 'KKIAPAY_SECRET_KEY', None)

    headers = {
        'x-api-key': kkiapay_key, 
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    }
    
    try:
        logger.info(f"Verifying transaction {transaction_id} on {verify_url}")
        
        response = requests.post(verify_url, json={'transactionId': transaction_id}, headers=headers)
        
        # Log response for debugging
        logger.debug(f"Kkiapay Status: {response.status_code}, Body: {response.text[:200]}")

        try:
            data = response.json()
        except ValueError:
            logger.error(f"Invalid JSON from Kkiapay. Status: {response.status_code}, Body: {response.text}")
            raise ValidationError("Invalid response from payment provider.")
        
        if response.status_code == 200 and data.get('status') == 'SUCCESS':
            return data
        else:
            logger.warning(f"Payment verification failed. Result: {data}")
            return None
            
    except requests.RequestException as e:
        logger.exception("Network error during payment verification")
        raise ValidationError(f"Payment verification network error: {str(e)}")
