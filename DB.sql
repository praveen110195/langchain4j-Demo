INSERT INTO orders (
    order_id, "customername", "productname", status,
    "currentlocation", "expecteddelivery", "totalamount", "paymentstatus"
)
VALUES
    ('ORD-1001', 'Arjun Nair', 'Mechanical Keyboard', 'IN_TRANSIT', 'Bengaluru Hub', CURRENT_DATE + INTERVAL '2 days', 5499.00, 'PAID'),
    ('ORD-1002', 'Meera Kulkarni', 'USB-C Docking Station', 'SHIPPED', 'Pune Distribution', CURRENT_DATE + INTERVAL '3 days', 8299.00, 'PAID'),
    ('ORD-1003', 'Rohan Deshmukh', 'Noise Cancelling Headphones', 'PROCESSING', 'Mumbai Warehouse', CURRENT_DATE + INTERVAL '5 days', 12999.00, 'PENDING')
    ON CONFLICT (order_id) DO NOTHING;


INSERT INTO refund_policy ("orderstatus", eligible, message)
SELECT v.order_status, v.eligible, v.message
FROM (
         VALUES
             ('PROCESSING', true, 'Order can be cancelled and refunded in full before dispatch.'),
             ('IN_TRANSIT', false, 'Order is already in transit; refund is available after delivery and return inspection.'),
             ('SHIPPED', false, 'Order has been shipped; eligible for return and refund once delivered.'),
             ('DELIVERED', true, 'Eligible for refund within 7 days of delivery if the item is unused and intact.'),
             ('CANCELLED', false, 'Order is already cancelled; no additional refund applies.')
     ) AS v(order_status, eligible, message)
WHERE NOT EXISTS (
    SELECT 1
    FROM refund_policy rp
    WHERE rp."orderstatus" = v.order_status
);