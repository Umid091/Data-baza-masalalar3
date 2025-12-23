
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



 -- 17-masla:Eng ko`p summadagi buyurtma qilgan 5ta haridorni topuvchi so`rov yozing (Customers, Orders
 va Order Details)
 select c.company_name, sum(od.unit_price*od.quantity) from  customers c
 inner join orders o on o.customer_id=c.customer_id
 inner join order_details od on od.order_id=o.order_id
 group by c.company_name, od.unit_price
 order by od.unit_price desc
 limit 5


-- 18-masala:Buyurtmalar soni 50tadan kam bo`lgan ishchilar haqida ma`lumotni topuvchi so`rov yozing
 (Employees va Orders)
 select e.last_name, count(o.order_id) from employees e
 inner join orders o on o.employee_id=e.employee_id
 group by e.last_name
 having count(o.order_id)<50


-- 19-masala:Har bir yil bo`yicha buyurtmalar sonini chop eting (Oraliq nazoratdan)
 select to_char(order_date,'YYYY'), count(o.order_id) from orders o
 group by to_char(order_date,'YYYY')




-- 20-masala:1997-yil may oyida eng ko`p buyurtma qabul qilingan beshta kunni chop eting (Oraliq
-- nazoratdan)
 select to_char(order_date,'YYYY-MM-DD'), count(order_id) from orders
 where to_char(order_date,'YYYY-MM')='1997-05'
 group by to_char(order_date,'YYYY-MM-DD')
 order by count(order_id) desc
 limit 5




-- 21-masala:1996-yili qaysi oyida eng ko’p mahsulot zakaz qilinganligini aniqlab beruvchi so’rov
-- shakllantiring.
 select to_char(order_date,'YYYY-MM'), count(order_id) from orders
 where to_char(order_date,'YYYY')='1996'
 group by to_char(order_date,'YYYY-MM')
 having count(order_id)=(select  count(order_id) from orders
 where to_char(order_date,'YYYY')='1996'
 group by to_char(order_date,'YYYY-MM')
 order by  count(order_id) desc limit 1)
 order by  count(order_id) desc




-- 22-masala:Eng ko’p buyurtma qabul qilingan 10ta kunni chop etish
 select to_char(order_date,'YYYY-MM-DD'), count(order_id) from orders
 where to_char(order_date,'YYYY')='1996'



-- 23-masala:Vaqtida yetkazib berilgan mahsulotlarni qancha muddatda yetkazilganligi va kim tomonidan
-- yetkazilganligi haqida ma’lumotni shakllantiring
 select s.company_name , p.product_name, (o.shipped_date-o.order_date) from suppliers s
 inner join products p on p.supplier_id=s.supplier_id
 inner join order_details od on od.product_id=p.product_id
 inner join orders o on o.order_id=od.order_id
 where o.shipped_date<=o.required_date




-- 24-masala:Ikki va undan ortiq buyurtma bergan haridorlar soni top 50tasini chiqarish
 select c.company_name , count(o.order_id) from customers c
 inner join orders o on o.customer_id=c.customer_id
 inner join order_details od on od.order_id=o.order_id
 group by c.company_name
 having count(o.order_id)>=2
 order by count(o.order_id)
 limit 50

