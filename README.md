The Boxing Kata
=================

Everyone who has dental insurance through Beam receives perks in the form of electric toothbrushes, replacement brush heads, and product (toothpaste and floss). These perks are provided at the start of an insurance contract and then semi-frequently through the life of the contract. Perks are sent based on family insurance plans and individual family member perk preferences.  Each family member gets to choose a toothbrush color, and will receive replacement toothbrush heads of the same color. Each family plan is based on the perks interval of their contract.

This kata involves determining how the perks are boxed up and shipped based on the insurance contract rules, family member perks preferences, and shipping constraints. Given an input file of insured customers with their contract data and preferences, an output file of perk boxes will be generated.

User Stories
--------------

**Starter Boxes**

_As an insured member with perks_<br>
_In order to start taking advantage of my perks_<br>
_I want to receive a starter box with my toothbrush_<br>

When a contract becomes effective then members should receive a starter box which contains their brushes. Members of families with quarterly perks (based on the primary insured's contract perks interval) should receive starter boxes with a brush of their preferred color. Members of families with semi-annual perks should receive starter boxes which include 1 brush of their preferred color, and 1 replacement head of the same color. When the perks boxes output file is generated then a box with the product_type of "starter" should be generated for members which contain brushes and replacement heads (in the case of semi-annual perks) of their preferred color, and a shipping date that matches the contract effective date based on the primary insured's contract.

**Scheduling Perks Refills**

_As an insured member_<br>
_In order to continue taking advantage of my perks_<br>
_I want to receive my perks refill boxes on a regular schedule_<br>

Members should receive perks throughout the length of the contract (1 year). Members of families with quarterly perks (based on the primary insured's contract perks interval) should receive refill boxes every three months. A quarterly refill box contains 1 replacement head of the member's preferred color.  Members of families with semi-annual perks should receive refill boxes every six months. A semi-annual refill box contains 2 replacement heads of the member's preferred color.  

The shipping date for a box should be based on the shipping date of the member's chronologically previous box plus the number of months of the contract's perks interval. Refill boxes are always scheduled after starter boxes.   

When the perks boxes output file is generated then enough refill boxes to cover the 1 year contract should be created. Keep in mind that starter boxes should be included in this calculation. These boxes should have a product type of "refill", a number of replacement heads, and a shipping date using the rules above.

**Shipping Address**

_As an insured member_<br>
_In order to receive my perks_<br>
_I want my perks to be shipped to my primary insured member_<br>

When perk boxes are created they are given an accompanying shipping address and addressee. The shipping address is determined by the primary insured member for a given family who is also the addressee, unless a member has their own address, in which case that member's address and name should be used. When the perks boxes output file is generated then each box should have a shipping address and an addressee.

**Bundling Perks**

_As a Beam shipping manager_<br>
_In order to save money on shipping_<br>
_I want perks to be bundled together_<br>

Shipping many boxes which contain only a few items is time-consuming, inefficient, and costly. In order to reduce the number of boxes to be shipped we need to bundle member's perks together as much as possible.  Members on the same family plan should have their perks bundled according to product type (starter or refill). Boxes should be filled to ship as many perks as possible. A starter box can contain a maximum of 2 brushes and 2 replacement heads. A refill box can contain a maximum of 4 replacement heads.  If a member has a different address than their primary insured's address then their perks should be boxed separately. When the perks boxes output file is generated then a family's individual member boxes should be bundled together to fill the boxes using the rules above.

**Mail Class**

_As a Beam shipping manager_<br>
_In order to save money on shipping_<br>
_I want to determine mail class_<br>

In order to manage shipping costs and to deliver perks quickly we want to determine the mail class of boxes. Mail class is based on the weight of box. Boxes that weigh 16oz or more have a class of "priority".  Boxes that weigh less than 16oz have a mail class of "first". Weight is calculated as such: 1 brush weighs 9oz, and 1 replacement head weighs 1oz. Additionally, for each brush or replacement head that is shipped a paste kit is also shipped which contains toothpaste and floss. A past kit weighs 7.6 oz.  When the perks boxes output file is generated then each box should have a mail class.

Example Input File
----------------
The input file is a CSV file which contains the following fields:

```
id,first_name,last_name,brush_color,primary_insured_id,contract_effective_at,address,contract_perks_interval
1,Han,Solo,blue,,2019-01-01,"The Millenium Falcon",3
2,Anakin,Skywalker,blue,,2019-03-15,"Corescant",6
3,Padme,Skywalker,pink,,,"Corescant",
4,Luke,Skywalker,blue,,,"Corescant",
5,Leia,Skywalker,green,,,"Corescant",
6,Cee,Three-Pio,blue,,2019-04-01,"Tatooine",6
7,Artoo,Deetoo,blue,6,,"Naboo",
```

Example Output File
------------------

```
addressee,address,brushes_blue,brushes_green,brushes_pink,replacement_heads_blue,replacement_heads_green,replacement_heads_pink,product_type,mail_class,shipping_date
Han Solo,"The Millenium Falcon",1,0,0,0,0,0,starter,priority,2019-01-01
Han Solo,"The Millenium Falcon",0,0,0,1,0,0,refill,first,2019-04-01
Han Solo,"The Millenium Falcon",0,0,0,1,0,0,refill,first,2019-07-01
Han Solo,"The Millenium Falcon",0,0,0,1,0,0,refill,first,2019-10-01
Anakin Skywalker,"Corescant",2,0,0,2,0,0,starter,priority,2019-03-15
Anakin Skywalker,"Corescant",0,1,1,0,1,1,starter,priority,2019-03-15
Anakin Skywalker,"Corescant",0,0,0,4,0,0,refill,priority,2019-09-15
Anakin Skywalker,"Corescant",0,0,0,0,2,2,refill,priority,2019-09-15
Cee ThreePio,"Tatooine",1,0,0,1,0,0,starter,priority,2019-04-01
Cee ThreePio,"Tatooine",0,0,0,2,0,0,starter,priority,2019-07-01
Cee ThreePio,"Tatooine",0,0,0,2,0,0,starter,priority,2019-10-01
Cee ThreePio,"Tatooine",0,0,0,2,0,0,starter,priority,2020-01-01
Artoo Deetoo,"Naboo",1,0,0,1,0,0,starter,priority,2019-04-01
Artoo Deetoo,"Naboo",0,0,0,2,0,0,starter,priority,2019-07-01
Artoo Deetoo,"Naboo",0,0,0,2,0,0,starter,priority,2019-10-01
Artoo Deetoo,"Naboo",0,0,0,2,0,0,starter,priority,2020-01-01
```
