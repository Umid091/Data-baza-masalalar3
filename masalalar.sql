
-- 11-masala:Ko`p zakaz qilingan ammo narxi arzon mahsulotlar ro`yxatini shakllantiring

 select 	p.product_name, p.unit_price, count(od.product_id) from products p
 inner join order_details od on od.product_id=p.product_id
 group by p.product_name, p.unit_price
 having   p.unit_price=(select 	 min(p.unit_price) from products p
 inner join order_details od on od.product_id=p.product_id
 group by p.product_name, p.unit_price
 order by min(p.unit_price) limit 1)
 order by count(od.product_id) desc


-- 12-masala:Canadada yashovchi va zakazlar soni kam bo`lgan kompaniyalar soni chiqarilsin
 select s.company_name ,count(od.order_id) from suppliers s
 inner join products p on p.supplier_id=s.supplier_id
 inner join order_details od on od.product_id=p.product_id
 where s.country='Canada'
 group by s.company_name
 order by count(od.order_id)
 limit 1




-- 13-masala:Har bir kategoriya bo`yicha eng qimmat maxsulotni chop etuvchi so`rov yozing (products va
-- categories)

 select  category_name, p.unit_price from products p
 inner join categories c on c.category_id=p.category_id
 group by category_name, p.unit_price
 order by p.unit_price desc
 limit 1



-- 14-masala:Eng ko`p buyurtma qilgan 10ta haridorni chop etuvchi so`rov yozing (Customers va Orders)
 select c.company_name, count(o.order_id) from customers c
 inner join orders o on o.customer_id=c.customer_id
 group by c.company_name
 order by count(o.order_id) desc limit 10




-- 15-masala:Eng kam sotilgan 10ta maxsulotni topuvchi so`rov yozing (Products va Order Details)

 select p.product_name ,count(od.product_id) from products p
 inner join order_details od on od.product_id=p.product_id
 group by p.product_name
 having count(od.product_id)=any(select  count(od.product_id) from products p
 inner join order_details od on od.product_id=p.product_id
 group by p.product_name
 order by count(od.product_id) limit 10)
 order by count(od.product_id)



-- 16-masala:1996-yilda buyurtma qilingan maxsulotlarning umumiy summasini topuvchi so`rov yozing
-- (Orders va Order Details)

 select to_char(order_date,'YYYY'), sum(od.unit_price) from orders o
 inner join order_details od on od.order_id=o.order_id
 where to_char(order_date,'YYYY')='1996'
 group by to_char(order_date,'YYYY')