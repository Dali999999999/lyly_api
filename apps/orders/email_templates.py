from django.conf import settings
from django.utils.html import strip_tags
from datetime import datetime

def get_base_html(content, title="Notification Lyly's Bakery"):
    """
    Base HTML wrapper with responsive design, logo, and footer.
    """
    # Define brand colors
    PRIMARY_COLOR = "#c5874a" # Bakery Gold
    BG_COLOR = "#f5f5f4" # Stone 100 equivalent
    TEXT_COLOR = "#44403c" # Stone 700
    CURRENT_YEAR = datetime.now().year

    return f"""
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title}</title>
    <style>
        body {{ margin: 0; padding: 0; background-color: {BG_COLOR}; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; color: {TEXT_COLOR}; }}
        .container {{ max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; }}
        .header {{ background-color: #ffffff; padding: 30px 20px; text-align: center; border-bottom: 3px solid {PRIMARY_COLOR}; }}
        .logo {{ font-size: 28px; font-weight: bold; color: {PRIMARY_COLOR}; text-decoration: none; font-family: 'Georgia', serif; }}
        .content {{ padding: 30px 25px; line-height: 1.6; }}
        .footer {{ background-color: #f9fafb; padding: 20px; text-align: center; font-size: 12px; color: #9ca3af; border-top: 1px solid #e5e7eb; }}
        .btn {{ display: inline-block; padding: 12px 24px; background-color: {PRIMARY_COLOR}; color: white; text-decoration: none; border-radius: 6px; font-weight: bold; margin-top: 20px; }}
        .info-box {{ background-color: #fefce8; border-left: 4px solid {PRIMARY_COLOR}; padding: 15px; margin: 20px 0; border-radius: 4px; }}
        .table-wrapper {{ width: 100%; overflow-x: auto; margin: 20px 0; }}
        table {{ width: 100%; border-collapse: collapse; font-size: 14px; }}
        th {{ text-align: left; padding: 12px; border-bottom: 2px solid #e5e7eb; color: {TEXT_COLOR}; font-weight: 600; }}
        td {{ padding: 12px; border-bottom: 1px solid #e5e7eb; vertical-align: top; }}
        .total-row td {{ font-weight: bold; font-size: 16px; border-top: 2px solid {PRIMARY_COLOR}; color: {PRIMARY_COLOR}; }}
        .status-badge {{ background-color: {PRIMARY_COLOR}; color: white; padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; display: inline-block; }}
        .address-box {{ background-color: #ecfdf5; border: 1px solid #a7f3d0; padding: 16px; border-radius: 8px; margin-top: 10px; }}
        .gps-btn {{ display: inline-block; background-color: #059669; color: white !important; padding: 10px 15px; text-decoration: none; border-radius: 6px; font-weight: bold; font-size: 14px; margin-top: 10px; }}
    </style>
</head>
<body>
    <div style="padding: 20px 0;">
        <div class="container">
            <div class="header">
                <a href="#" class="logo">Lyly's Bakery</a>
            </div>
            <div class="content">
                {content}
            </div>
            <div class="footer">
                <p>&copy; {CURRENT_YEAR} Lyly's Bakery. Tous droits réservés.</p>
                <p>Ceci est un email automatique, merci de ne pas répondre directement.</p>
            </div>
        </div>
    </div>
</body>
</html>
    """

def get_order_confirmation_email(order):
    """
    Generates the HTML email for order confirmation.
    """
    items_html = ""
    for item in order.items.all():
        price_display = f"{item.price:,.0f} FCFA"
        items_html += f"""
        <tr>
            <td>
                <strong>{item.product_name}</strong><br>
                <span style="font-size: 12px; color: #78716c;">Quantité: {item.quantity}</span>
            </td>
            <td style="text-align: right;">{price_display}</td>
        </tr>
        """
    
    # Calculate Total
    total_display = f"{order.total_amount:,.0f} FCFA"
    
    # Shipping info parsing
    shipping_info = order.shipping_address_json if isinstance(order.shipping_address_json, dict) else {}
    
    # Address Logic
    address_html = ""
    
    # Check for GPS coordinates (supports both 'gps' object and direct lat/lng)
    lat = shipping_info.get('latitude')
    lng = shipping_info.get('longitude')
    
    # Also check nested 'gps' object if present
    if not lat and 'gps' in shipping_info and isinstance(shipping_info['gps'], dict):
        lat = shipping_info['gps'].get('latitude')
        lng = shipping_info['gps'].get('longitude')

    city = shipping_info.get('city', 'Cotonou')
    quartier = shipping_info.get('quartier', '')
    details = shipping_info.get('street', '') or shipping_info.get('details', '') # Fallback keys
    
    if lat and lng:
        # Smart GPS Display
        maps_link = f"https://www.google.com/maps/search/?api=1&query={lat},{lng}"
        address_html = f"""
        <div class="address-box">
            <p style="margin: 0 0 10px 0;"><strong>📍 Localisation GPS reçue</strong></p>
            <p style="margin: 0; font-size: 14px; color: #374151;">Votre position a été enregistrée avec précision.</p>
            <a href="{maps_link}" class="gps-btn" target="_blank">Voir sur Google Maps</a>
            {f'<p style="margin: 10px 0 0 0; font-size: 13px; color: #6b7280;">Détails compl.: {details}</p>' if details else ''}
        </div>
        """
    else:
        # Manual Address Display
        address_html = f"""
        <div style="background-color: #f9fafb; padding: 15px; border-radius: 8px; border: 1px solid #e5e7eb;">
            <p style="margin: 5px 0;"><strong>Ville :</strong> {city}</p>
            {f'<p style="margin: 5px 0;"><strong>Quartier :</strong> {quartier}</p>' if quartier else ''}
            <p style="margin: 5px 0;"><strong>Détails/Repère :</strong> {details if details else 'Aucun détail fourni'}</p>
        </div>
        """

    content = f"""
    <h2 style="color: #44403c; margin-top: 0;">Merci pour votre commande, {order.full_name} ! 🎉</h2>
    <p>Nous avons bien reçu votre commande <strong>#{order.id}</strong> et nous la préparons avec soin.</p>
    
    <div class="info-box">
        <strong>Statut actuel :</strong> En préparation
    </div>

    <h3 style="border-bottom: 1px solid #e5e7eb; padding-bottom: 10px; margin-top: 30px;">Détails de la commande</h3>
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Article</th>
                    <th style="text-align: right;">Prix</th>
                </tr>
            </thead>
            <tbody>
                {items_html}
                <tr class="total-row">
                    <td>TOTAL</td>
                    <td style="text-align: right;">{total_display}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h3 style="border-bottom: 1px solid #e5e7eb; padding-bottom: 10px; margin-top: 30px;">Adresse de livraison</h3>
    {address_html}

    <div style="text-align: center; margin-top: 40px;">
        <p>Une question ? Contactez-nous au <strong>+229 01 02 03 04</strong></p>
    </div>
    """
    
    html_content = get_base_html(content, title=f"Confirmation Commande #{order.id}")
    return {
        'subject': f"🍞 Confirmation de votre commande #{order.id}",
        'html_message': html_content,
        'plain_message': strip_tags(html_content)
    }

def get_status_update_email(order, new_status):
    """
    Generates the HTML email for status updates.
    """
    status_messages = {
        'En attente': "Votre commande est en attente de validation.",
        'En préparation': "Bonne nouvelle ! Nos chefs sont en train de préparer votre commande. 👨‍🍳",
        'Livré': "Votre commande a été livrée ! Bon appétit ! 😋",
        'Annulé': "Votre commande a été annulée.",
        'Payé': "Votre paiement a été confirmé avec succès. ✅"
    }

    message_body = status_messages.get(new_status, f"Le statut de votre commande a changé : <strong>{new_status}</strong>")

    content = f"""
    <h2 style="color: #44403c; margin-top: 0;">Mise à jour de votre commande #{order.id}</h2>
    
    <div style="text-align: center; padding: 20px;">
        <span class="status-badge" style="font-size: 16px; padding: 10px 20px;">{new_status.upper()}</span>
    </div>

    <p style="font-size: 16px; text-align: center;">{message_body}</p>
    
    <div class="info-box">
        <p style="margin: 0;"><strong>Récapitulatif :</strong> {order.items.count()} articles • Total: {order.total_amount:,.0f} FCFA</p>
    </div>

    <div style="text-align: center; margin-top: 30px;">
        <p>Merci de votre confiance !</p>
    </div>
    """
    
    html_content = get_base_html(content, title=f"Mise à jour Commande #{order.id}")
    return {
        'subject': f"🔔 Mise à jour : Commande #{order.id} est {new_status}",
        'html_message': html_content,
        'plain_message': strip_tags(html_content)
    }
