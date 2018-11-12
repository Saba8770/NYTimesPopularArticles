# NYTimesPopularArticles
This is sample application which display the NY Times most popular articles

### Feature ###
* This App uses the NY Times popular articles API.
* Lists all the news based on period 30.
* Auto downloading of images and cache them.

### Requirement ###
* Xcode: 9.1
* Programming language: Swift 4.0
* Device supported: All 
* Orientation:  All
* Minimum iOS deployment target: 10.0 and above


### Design architecture  ###
* VIPER


### How to use it ###
Using NY times api which I have generated through NY Times developer site


### Basic understanding ###

* InteractorFactory: This is a singleton class and fulfills the dependency injection.

* HomeViewController: This is a controller class sole UI logic drive from here.

* HomePresenter: This is a class which acts as a bridge between Controller and Interactor, Controller and Wireframe.

* HomeInteractor: Responsible for querying the NY times popular article api and parsing the recieved data. As of now showing 30 period NY times articles, you can change it to 1 or 7 whatever you wish. Just go inside the HomeInteractor and search for `getArticles(completion` method you will see a method call with `period` pass the period as per your wish.
for more detail visit https://developer.nytimes.com/most_popular_api_v2.json

* DownloadInteractor: This class is responsible for downloading the image for recieved popular articles.

* QueryService: Network class which take care the basic network request and process the received response.

* DownloadService: This is also a network class perform image download task.


### Unit test cases ###
 * I have also written unit test cases. You can run them by tapping command + U key together.













