# FlyAway
Fly Away an Air ticket Booking service website . Developed by Mohammad Azaz

FlyAway (An Airline Booking Portal)
Developed by Mohammad Azaz
•	Sprints planned and the tasks achieved in them 
	Flyaway was divided in 3 sprints of 1 week each.
Sprint 1: -
•	Initialized the project, made it Hibernate  project and added dependencies: - MySql connector, Hibernate libraries, JSTL, Servlet API.
•	Setting MySQL database environment and tomcat server 
•	Made E.R. diagram for database and entities relationship.
•	Made classes for entities and established relationship between them.
•	Configured hibernate and mapped classes as entities.
•	Populated the data by hibernate 
  Sprint 2: -
•	Planned the structure of the website and navigation across it.
•	Made a Hibernate util. class to use it across the servlets.
•	Made servlets for each class list and set up navigation link for them.
•	Made a common View page for each class’s view rendering.
•	Made the header and footer jsp pages to include it across every page
•	Made an error page errorpage.jsp and set it as the error page by whole website by including it in the header tag of header.jsp file.
 Sprint 3: -
•	Made the master list JSP for master list of places for source and destination, master list of airlines.
•	Also Made A list of flights where each flight has a source, destination, airline, and ticket price
•	Set up Servlets for each of the master list to send data as a list.
•	Made main.css for applying styles throughout the website. 
•	Added bootstrap CSS library and jQuery JavaScript library to speedup designing process using ready to use libraries.
•	Added & configure SendMail api to send mail on successful registration/ booking.
•	Modified the navigation with the help of button’s and added the navigation to home page in the Header Tag.
•	Revamped and modified the structure of the data rendering with the additional styles and best practices.

● Core concepts used in the project 
•	Server request response object 
•	HTTP Session, Cookies URL Redirect Hidden Field.
•	Collection Framework
•	DateTime object with simpleDateFormat
•	Hibernate JPA, Different types of mapping (one to one, one to many, many to one, many to many).
•	Sorting technique using database query as well as using Collection framework comparator methods.
•	MVC Framework where View (jsp/Html pages) , Controller (Servlet pages), Data Model (Entity classes and interface which interact to backend database using hibernate framework)
•	Java’s SendMail API to send email.
•	Java server page and Servlet
•	HTML/CSS to design view
•	Web container such as Tomcat server usage deployment of web application and running/configuration.
•	MySQL Database and SQL Query language.
● Links to the GitHub repository to verify the project completion
Classes: -
There were 7 entity classes named Flight, Booking, Traveller, Airline, Airport, User, Admin and Classes. Which all are inside dto layer i.e com.dto package.
Com.dto package

On top of dto layer we have DAO layer which provides interface to access database CRUD operation as well implements interface using Hibernate Session , Session factory and Transaction objects.
Com.dao Package

One top of dao layer controller layer is there where corresponding servlet has been added to handle the user request and provide appropriate response object to View layer.
Com.controller Package.

At top most layer (View) we have webcontent like JSP/HTML/CSS and other files through which user intracts and sends request or receives response.


Com.util package to send mail and for some helper classes like format date etc 

In the hibernate.cfg.xml we have all the configuration related to database connectivity as well as the resource class defined. As we have used annotated class so each entity class has annotation related to database entities like table, column and mapping .
 


    


Servlets: -
•	UserControllerServlet (Uses UserDAO Interface): - to Register a user and send send mail on successful registration -used by Register.jsp redirect to sendmail.jsp and registerSuccess.jsp.
Also used by admin to view /Edit/Delete user by using Users.jsp file

•	LoginServlet (Uses UserDAO interface): - to Authenticate a user login using Login.jsp. If Authentication failes user gets appropriate error message. If successful set the Session object and redirect User to Home.jsp page

•	AdminLoginServlet (Uses AdminDAO interface): - to Authenticate a Admin login using LoginAdmin.jsp. If Authentication failes user gets appropriate error message. If successful set the Session object and redirect admin to HomeAdmin.jsp page


•	ChangePassword Servlet: (Uses UserDAO & AdminDAO Interface): to Change the password for admin and User it handles user request from changePassword modal dialog.  

•	AirlineServlet (Used AirlineDAO interface): - to Mange airlines (Add/Edit/Delete/View airlines) by admin users. Note If a airline is deleted it also deletes dependent flight there is one to many relationship between airline and flight. Mapped with Airlines.jsp , and used by Flights.jsp 


•	AirportServlet (Uses AirportDAO interface ): - to Manage places (Airports ) for source and destination of a flight admin user can manage (Add/Edit/Delete/View) using Airports.jsp also used by Flight.jsp and SearchFlight.jsp to list From and To  airports (dropdown).

•	FlightServlet (Uses FlightDAO):- to Manage flight (Add/Edit/Delete/View)  admin uses Flights.jsp. User can also check flight status using FlightStatus.jsp .

•	BookingServelet (Uses BookingDAO Interface) :- to handle user booking request using Booking.jsp and provides control over booking to the user by BookingStatus.jsp .Admin can also view and manage bookings (Add/Edit/Delete/View) by using View_Bookings.jsp
JSP: -
•	index.jsp: - A JSP for showing the starting /Default page in  which all the navigation links and basic options like flight Search , flight status and register or login  option 

•	header.jsp: - Includes the header and link to the css style sheet to be included in other JSPs
•	footer.jsp: - A footer text with copyright mark and details of the developer to be included in other JSPs
•	Home.jsp: - Home page for user provides option to manage own booking, Search flight, check flight status, View and Edit Profile after successful login.
•	SearchFlight.jsp: - A user can search flight by providing Source , Destination airport , date and time of journey and providing number of travellers.
•	Booking.jsp: - Once the user select desire flight and click Book button user taken to booking page which shows Booking summary user has an option to apply promo code to get additional discount and Fare summary will be displayed then user click on Pay button , a dummy Payment gateway popup will be displayed.
•	BookingStatus.jsp:- Once the user confirms payment on Booking.jsp page user will redirected to BookingStatus.jsp page which will send an email to user’s email address with flight details and also display flight summay user can print the ticket also.
•	FlightStatus.jsp: User can check flight status by providing Flight ID , Flight status will be either Delayed (highlighted in red) Preponed (highlighted in Yellow) or OnTime (highlighted in green).
•	Uer_Bookings.jsp : A user can view own booking cancel  or edit traveller detail print ticket.
•	User_Profile.jsp: It provides facility to Edit /View profile details such as Name, phone, email etc.
•	HomeAdmin.jsp: It provides gateway to admin functionality to admin user and admin can perform various configuration using this page.
•	Airports.jsp : To mange airports admin uses this page.
•	Airlines.jsp :To manage airlines list admin uses this page. 
•	Flights.jsp :To manage Flight list admin uses this page. 
•	Users.jsp :To manage user list admin uses this page. 
•	Register.jsp : New user can create/signup an account and consume services on FlyAway.

•	Error.jsp:- isErrorPage is true and set as the errorpage in Header.jsp so it can be included in every other pages.

CSS file: -
main.css is a file for all the style sheet across the website embedded in header.jsp so it can be included in entire website. 
Bootstrap library:-To accelerate design process we used popular css framework.

JavaSript:-
	jQuery : A popular library used for form validation and modal popup.
HTML5 is also used to design date-time field, number field and used UI validation using it.

Note :- After every class push the code to git hub git hub link is – 
https://github.com/


 
If any issue please fill free to contact me my details are- 

Thanks 
Develop by 
Mohammad Azaz











