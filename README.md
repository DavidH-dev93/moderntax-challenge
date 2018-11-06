The Boxing Kata
=================

Everyone who has dental insurance through Beam receives perks in the form of electric toothbrushes, replacement brush heads, and product (toothpaste and floss). These perks are provided at the start of an insurance contract and then semi-frequently through the life of the contract.  Each family member gets to choose a toothbrush color, and will receive replacement toothbrush heads of the same color.

This kata involves building the brains of a boxing system which will determining how the perks are boxed up and shipped. Given a family's brush color preferences then the system will generate a description of how the boxes should be filled.

User Stories
--------------

**Importing family preferences**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to add family member brush preferences_<br>

The shipping manager can import the family data.  When the system receives the input file then the brush color counts will be displayed in the format below.

```
BRUSH PREFERENCES
blue: 2
pink: 1
green: 2
```

**Starter boxes**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to fill starter boxes_<br>

Now that member data has been imported the shipping manager can begin filling boxes. A family should receive starter boxes with a brush and replacement brush head for each of their preferred colors. Each member will receive one brush and one replacement head. A starter box can contain a maximum of 2 brushes and 2 replacement heads. When starter boxes are generated then a number of boxes are output.  Using the brush preferences example above box output will be generated in the following format:

```
STARTER BOX
2 blue brushes
2 blue replacement heads

STARTER BOX
2 green brushes
2 green replacement head

STARTER BOX
1 pink brush
1 pink replacement head
```

If no family preferences have been entered then the message "NO BOXES GENERATED" should be displayed.

**Refills**

_Aa a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to fill refill boxes_<br>

A family should receive refill boxes with a replacement brush head for each of their preferred colors. A refill box can contain a maximum of 4 replacement heads. When refill boxes are generated then a number of boxes are output.  Using the brush preferences example above box output will be generated in the following format:

```
REFILL BOX
2 blue replacement heads
2 green replacement heads

REFILL BOX
1 pink replacement head
```

**Scheduling**

_As a Beam Shipping Manager_<br>
_In order to ship perks_<br>
_I want to schedule boxes for shipping_<br>

Members should receive perks throughout the length of the contract (1 year).  The shipping date is based on the contract effective date of the primary insured family member.  Starter boxes should be scheduled on the contract effective date.  Refills are scheduled every 90 days after that for the remainder of the year. Each box should have a line appended with its schedule.

Example for a refill: `Schedule: 2018-04-01, 2018-06-30, 2018-09-28`

**Mail Class**

_As a Beam shipping manager_<br>
_In order to save money on shipping_<br>
_I want to determine mail class_<br>

In order to manage shipping costs and to deliver perks quickly we want to determine the mail class of boxes. Mail class is based on the weight of box. Boxes that weigh 16oz or more have a class of "priority".  Boxes that weigh less than 16oz have a mail class of "first". Weight is calculated as such: 1 brush weighs 9oz, and 1 replacement head weighs 1oz. Additionally, for each brush or replacement head that is shipped a paste kit is also shipped which contains toothpaste and floss. A past kit weighs 7.6 oz.  Each box should have a line appended with its mail class.

Example: `Mail class: first`

Example Input File
----------------
The input file is a CSV file which contains the following fields:

```
id,name,brush_color,primary_insured_id,contract_effective_date
2,Anakin,blue,,2018-01-01
3,Padme,pink,2,,
4,Luke,blue,2,,
5,Leia,green,2,,
6,Ben,green,2,,
```
