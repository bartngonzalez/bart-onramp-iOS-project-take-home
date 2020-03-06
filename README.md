# bart-onramp-iOS-project-take-home

## Description
OnrampNews iOS application shows articles provided by the Google News API. Users are shown a list of articles that can be selected and redirected to the source website. The (My News) tab displays articles related to the users location. (Headlines) tab shows top articles based on five different categories (Business, Technology, Sports, Science and Health). The (Search) view allows the user's input retrieving a list of news articles based on the keyword.

## Architecture

- Storyboards
	- MainTabBarController.storyboard: is a UITabBarController composed of two tab bar items (MyNews and Headlines).

	- MyNews.storyboard: is a UITableViewController (Table) that displays news articles relevant to the users location.

	- Headlines.storyboard: is a UITableViewController (Table) that displays trending (Headline) articles based on five different categories (Business, Technology, Sports, Science and Health).

	- Search.storyboard: is a UITableViewController (Table) that allows the user to search for articles based on their input provided in the Search Bar.

	- Signin.storyboard: is a UITableViewController (Table) mimics a request to Authenticate a based on credentials provided. (*Username = root* & *Password = root*).

- **ViewControllers**
	- MyNewsVC.swift: requests the users location utilizing *CLLocationManager* to get latitude and longitude. Users latitude and longitude is then converted to a readable address specifically the city using (*Open Cage Data API*). The city is then combined with the URL required to get the articles using (*Googles News API*). If user denies or disables the location the VC will not call the APIs and clear the table if occupide. Articles are assigned to the (**ArticleTableViewCell.xib**) which is then displayed on the (Table View).

	- HeadlinesVC.swift: combines any of the five topics (Business, Technology, Sports, Science and Health) with the URL required to get articles from (*Google News API*). The VC creates two sections in the (Table). The first section contains a UITableViewCell (**TopicsTableViewCell.xib**) that holds a UICollectionView containing a list of UICollectionViewCell from the (**TopicCollectionViewCell.xib**) allowing the user to select any of the five categories mentioned. The second section contains a list of UITableViewCells derived from (**ArticleTableViewCell.xib**).

	- SearchVC.swift: allows the user to enter a keyword into the UISearchBar. The input is then combined with (*Google News API*) URL. Articles are then displayed on the (Table View). The cells are created using the (**ArticleTableViewCell.xib**).

	- SigninVC.swift: based on credentials from (**usernameTextField** and **passwordTextField**) the VC calls the functions in the (**Switcher.swift**) class to update the rootViewController.

- **ViewModels**
	- ArticleVM.swift: utilizing ***Codable*** the VM can decode the data (json) and assign the article values based of the (***Article***) object in the json response. ArticleVM formats the publishedAt (Date) from Unix Timestamp to hours based on the difference between the current date and timestamp.
	
	- LocationVM.swift: utilizing Codable the VM decodes the (json) then assigns the city based on the (***Components***) object from the API response.

- **Models**
	- Article.swift: structure that containes the articles (**id, name, author, title, url, urlToImage, publishedAt**). Article struct inherits from Codable allowing parsing.

	- Location.swift: structure containes the location (**city**) and a struct (**Components**) object that contains the city name within.

- **XIBs**
	- ArticleTableViewCellVC.swift: assigns the (**ArticleVM**) article values to the **IBOutlets**. Function (**setImageFromURL**) uses URLSession to get images from articles urlToImage.

	- ArticleTableViewCell.xib: is a **UITableViewCell** that is composed of (**UIImageView**: **article image**) and four UILabels for the articles (**Author Name**, **Article Title**, **Article Source** and **Article Publish Date**).

	- TopicsTableViewCellVC.swift: Configures the **UICollectionView Protocols** and registers the **TopicCollectionViewCellVC** in the (Table View)

	- TopicsTableViewCell.xib: is a  **UITableViewCell** that contains a **UICollectionView** that will hold the topics for the **Headlines.storyboard** (*Business, Technology, Sports, Science and Health*).

	- TopicCollectionViewCellVC.swift: Assigns the array data given by the **TopicsTableViewCell** to the IBOutlets.

	- TopicCollectionViewCell.xib: is a **UICollectionViewCell** that containes a (**UIlabel** and **UIImageView**). Label is for the topics text  and image will contain the topics icon.

- **Networking.swift**: handles the network request for  both the (**Google News API** and **Open Cage Data API**). By using a completion handler and returning a (**Result**) the VC (**View**) can decide on the UI logic based on the (**.success** or **.failure**) result.

- **Switcher.swift**: updates the window.rootViewController from both the (**AppDelegate** and **SceneDelegate**) swift files. UserDefaults.standard.bool(forKey: "isAuth") value (True or False) decides which Storyboard to display (**Login** or **MainTabBarController**)

## Design Pattern's
##### MVVM:
The design pattern I chose to go with was MVVM. This allowed for a much cleaner ViewController (View). For example, the ArticleVM.swift allowed me to format the date, parse the json and relaying the data to the View.

---
##### Networking:
By creating the Network.swift class I was able to request the data (json) from both the (Google News API and Open Cage Data API). Using a completion handler the view can simply decide what to show the user based on the result (.success or .failure).

---
##### UI Design:
Using the (UITableViewCell and UICollectionViewCell) XIBs kept the Storyboards design simple. This makes the tableview modular allowing for different cell designs.

## Screenshots
