# Level 5

This level is a little bit different: we are now looking for a Rails application that helps us manage workers and shift.

We are expecting a link to a hosted Rails application that enable us to:
- add and edit workers
- add and assign shifts
- consult shifts

The application should be as simple as possible (for example, authentication is not expected).

# Solution

The requested rails app is developed and deployed on Heroku. You can access it through:

https://lifenapp.herokuapp.com

Things you may want to know:

* You can make, edit or remove new workers and shifts.

* During making a new shift, you can choose a worker id from the workers which were built before

* Price or salary of a worker would be changed by assigning a new shift automatically

    * Editing a shift (worker id or its date) might affect the price 

* The app is feeded using the input data of level4

* Total price of workers, commission and number of interim shifts are computed and shown at home page

* Bootstrap4 is used to make the app a little bit stylish

* It is as simple as possible but there some other things which are possible to be added 

* Any feedback is appreciated
