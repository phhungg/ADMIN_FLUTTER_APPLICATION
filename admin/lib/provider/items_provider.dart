import 'package:admin/models/products_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ItemsCategory with ChangeNotifier {
  List<ProductsModels> get getProducts {
    return _items;
  }

  ProductsModels? findByproductId(String productId) {
    if (_items.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    ;
    return _items.firstWhere((element) => element.productId == productId);
  }

  List<ProductsModels> findByCategory({required String ctgName}) {
    List<ProductsModels> ctgList = _items
        .where(
          (element) => element.productCategory.toLowerCase().contains(
                ctgName.toLowerCase(),
              ),
        )
        .toList();
    return ctgList;
  }

  List<ProductsModels> searchQuery(
      {required String searchText, required List<ProductsModels> passedList}) {
    List<ProductsModels> searchList = passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  final foodDB = FirebaseFirestore.instance.collection("foods");
  Future<List<ProductsModels>> fetchProducts() async {
    try {
      await foodDB.get().then((foodSnapshot) {
        _items.clear();
        for (var element in foodSnapshot.docs) {
          _items.insert(0, ProductsModels.fromFirestore(element));
        }
      });
      notifyListeners();
      return _items;
    } catch (error) {
      rethrow;
    }
  }

  Stream<List<ProductsModels>> fetchProductsStream() {
    try {
      return foodDB.snapshots().map((snapshot) {
        _items.clear();
        // _products = [];
        for (var element in snapshot.docs) {
          _items.insert(0, ProductsModels.fromFirestore(element));
        }
        return _items;
      });
    } catch (e) {
      rethrow;
    }
  }

  final List<ProductsModels> _items = [
    //Hamburger
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Lamb burger with Indian spices and mint yogurt sauce',
      productPrice: '9.00',
      productCategory: 'Hamburgers',
      productDescription:
          'The filling is made from field-raised lamb, the lean shoulder meat contains 2/3 less fat than super-raised lamb. To make the meat tastier, you should grind it into smaller pieces before processing.',
      productImage:
          'https://i1-giadinh.vnecdn.net/2013/06/13/burger-1-1371112114.jpg?w=680&h=0&q=100&dpr=1&fit=crop&s=dqWhgkWQl_5E7vGDE-lXgw',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'American burger',
      productPrice: '9.00',
      productCategory: 'Hamburgers',
      productDescription:
          'Americas great burgers have become as heavy as wrestlers in recent times. Among fast food and expensive restaurant chains, it is almost absolutely huge.',
      productImage:
          'https://www.thespruceeats.com/thmb/vf61j0CDD-RYdis4LVqmBV5NDzU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/all-american-burgers-480989-hero-05-6d4542f5661c4fd6889c16a445478e0c.jpg',
      productQuantity: '10',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Turkey burger with cranberry and peach chili sauce',
      productPrice: '9.00',
      productCategory: 'Hamburgers',
      productDescription:
          'Enjoy the flavors of Thanksgiving all year long with a turkey burger. For meat, you should choose free-range turkey breast, this is white meat with very little fat and calories. Served with dried vegetables and red grapes',
      productImage:
          'https://img-global.cpcdn.com/recipes/c2058741ebedddfc/680x482cq70/burger-nguyen-cam-k%E1%BA%B9p-ga-tay-gia-v%E1%BB%8B-y-recipe-main-photo.jpg',
      productQuantity: '5',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'German Style Burger with Feta Aioli',
      productPrice: '9.00',
      productCategory: 'Hamburgers',
      productDescription:
          'This burger is stuffed with bell peppers and grilled lettuce for a German flavor. German food is famous for its healthy ingredients such as vegetables and olive oil. Therefore these burgers are a healthier alternative to traditional burgers.',
      productImage:
          'https://vcdn1-giadinh.vnecdn.net/2013/06/13/burger-15-1371112119.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=1bzjtjzXrkuZIenuoSFe-Q',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Turkey burger with grilled eggplant',
      productPrice: '5.00',
      productCategory: 'Hamburgers',
      productDescription:
          'Beef and other red meat contain a mixture called glutamate. Soy sauce and marmite, a powerful leavening agent sold in supermarkets (Australians love Vegemite), contain this substance, and adding a little to the turkey will give the burger an umami meaty taste.',
      productImage:
          'https://skinnyms.com/wp-content/uploads/2018/02/How-to-Make-Mediterranean-Grilled-Eggplant-Burgers-with-Cheese-Recipe-3-1200x797.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Blue cheese burger',
      productPrice: '9.00',
      productCategory: 'Hamburgers',
      productDescription:
          'A traditional hamburger will become more delicious when you add onions, some bread and egg whites to the meat. Using muffins, which are usually smaller than ravioli, blue cheese and meat become the main flavors of the dish. You can use shredded Swiss Cheddar cheese if you do not like blue cheese.',
      productImage:
          'https://hips.hearstapps.com/del.h-cdn.co/assets/17/16/1600x1200/sd-aspect-1492695774-blue-cheese-burger.jpg?resize=1200:*',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Salmon burger',
      productPrice: '9.00',
      productCategory: 'Hamburgers',
      productDescription:
          'This delicious and diet burger proves that salmon can be just as delicious as beef provided you use the correct mixture. Beef can be mixed together to form a patty, but salmon is too soft to form a patty like beef. In addition, if mixed with breadcrumbs or eggs, it can remove the smell of salmon. Solution: For the best taste, mix ¼ salmon with 1 layer of pate to create 1 delicious piece of salmon..',
      productImage:
          'https://www.acouplecooks.com/wp-content/uploads/2021/03/Salmon-Burger-003.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Korean grilled burger',
      productPrice: '2.50',
      productCategory: 'Hamburgers',
      productDescription:
          'The ingredients of the traditional burger can be varied by changing the toppings such as spicy kimchi, sirracha, crispy napa cabbage or water chestnut. Can be used with kimchi, pickles and noodles to enjoy the authentic Korean flavor.',
      productImage:
          'https://thecozyapron.com/wp-content/uploads/2015/06/korean-bbq-burger_thecozyapron_06-26-15_1.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle:
          'Spicy Poblano Burger with pickled red onions and chipotle cream',
      productPrice: '15.0',
      productCategory: 'Hamburgers',
      productDescription:
          'The burger with lean beef is a combination of panade, bread and meatballs soaked in milk to make them soft and moist. Sometimes in the mix are savory flavors commonly found in Mexican chorizo, like coriander, paprika and cumin.There is also a creamy smoked poblano sauce, and finally a piece of pickled red onion for a wonderful flavor. This vinegared onion recipe is not just for one batch but can be kept for several weeks in the refrigerator. You can use it for sandwiches or salads or for your next batch of poblano burgers.',
      productImage:
          'https://cdn.pixabay.com/photo/2016/08/31/21/47/burger-1634705_960_720.jpg',
      productQuantity: '20',
    ),

    //Desserts
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Lemon tart',
      productPrice: '20.0',
      productCategory: 'Desserts',
      productDescription:
          'Yellow lemon tart is a classic French cake with main ingredients being flour, eggs, grated lemon peel, unsalted butter, heavy cream... with 3 parts of crust, filling and cream layer.',
      productImage:
          'https://www.recipetineats.com/uploads/2021/06/French-Lemon-Tart_5-main.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Apple crumble',
      productPrice: '15.0',
      productCategory: 'Dwsserts',
      productDescription:
          'This is a type of cake originating from England. Today Apple crumble is transformed into many different versions but all have the common characteristics of a crispy crust, radiating the aroma of butter and the sweet taste of fresh apples.',
      productImage:
          'https://hips.hearstapps.com/hmg-prod/images/delish-091621-apple-crumb-pie-02-jg-1632846997.jpg?crop=1xw:0.843956043956044xh;center,top&resize=1200:*',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Crêpe',
      productPrice: '9.00',
      productCategory: 'Desserts',
      productDescription:
          'When serving Crêpe as a dessert, it will be sprinkled on top with a layer of Nutella (liquid chocolate + butter + sugar) and fresh fruits.',
      productImage:
          'https://www.allrecipes.com/thmb/qLWCKWuNr0v1NdjM-OzFIiOXAfk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/16383-basic-crepes-mfs_002-a07ca6b699e443ee9643034c225a4cfb.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Chocolate mousse',
      productPrice: '40.0',
      productCategory: 'Desserts',
      productDescription:
          'This is a typical dessert of French cuisine, made from two main ingredients: chocolate and egg whites.',
      productImage:
          'https://www.sugarsaltmagic.com/wp-content/uploads/2020/10/Eggless-Easy-Chocolate-Mousse-8FEATURED-500x500.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Pudding',
      productPrice: '9.00',
      productCategory: 'Desserts',
      productDescription:
          'Pudding is a sweet dessert but in Latin it means “small sausage”. Some popular types of pudding are: milk pudding, egg pudding, mango pudding, green tea pudding, strawberry milk pudding...',
      productImage:
          'https://www.huongnghiepaau.com/wp-content/uploads/2019/01/pudding-la-gi.jpg',
      productQuantity: '20',
    ),
    //Coffee
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Espresso',
      productPrice: '18.0',
      productCategory: 'Coffees',
      productDescription:
          'A very popular type of coffee in Italy and Spain; is brewed by forcing water under high pressure to flow through a quantity of extremely finely ground coffee. The result will be 25 - 30ml of drink with a layer of coffee oil cream with a dark yellow brown color (people call it crema) 5mm thick on the surface. A genuine cup of Espresso will have a very strong taste and will have a layer of fragrant crema on top without being bitter.',
      productImage:
          'https://mediamart.vn/images/uploads/data-2022/ghj-2Y33P1.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Cappuccino',
      productPrice: '18.0',
      productCategory: 'Coffees',
      productDescription:
          'Also originating from Italy, a standard Cappuccino will consist of 3 equal parts, which are: Espresso coffee mixed with double the amount of water (Espresso Lungo), hot milk and foamed milk. Next, sprinkle some cocoa powder or cinnamon powder on top, then use a mold, spoon or toothpick to stir/draw to create a shape for your product, it can be a heart shape, leaf shape, cloud shape, etc. eye-catching.',
      productImage:
          'https://mediamart.vn/images/uploads/data-2022/ghj-c1x3LL.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Cafe Latte',
      productPrice: '14.0',
      productCategory: 'Coffees',
      productDescription:
          'Cafe Latte simply means coffee and milk. For non-connoisseur drinkers, it is easy to confuse Cafe Latte with Cappuccino because these two types share the same 3 main ingredients. However, the difference is that when making Coffee Latte, people only add half the amount of hot milk; instead of making it equal like making Cappuccino. An Espresso is prepared with milk and milk powder in a 200ml glass or cup at a temperature of 600 and then add 0.5 - 1cm of milk powder on the surface.',
      productImage:
          'https://mediamart.vn/images/uploads/data-2022/ghj-t07H8J.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Traditional cafe',
      productPrice: '12.0',
      productCategory: 'Coffees',
      productDescription:
          'Coffee is the most popular and chosen drink today. Black coffee, milk coffee are prepared from pure coffee beans from the land of Robusta, Arabica or weasel coffee,... are considered strong traditional coffee. Depending on the needs and preferences, diners can choose a cup of coffee brewed directly or pre-brewed and then drink hot or with ice. Those who love pure coffee often choose a cup of black coffee without sugar, or can add 1-2 teaspoons of sugar. Those who like sweet, fragrant aroma will ask for a rich, sweet cup of milk coffee.',
      productImage:
          'https://mediamart.vn/images/uploads/data-2022/ghj-BOsK1B.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Latte Macchiato',
      productPrice: '25.0',
      productCategory: 'Coffees',
      productDescription:
          'Latte Macchiato (Latte) is a type of hot coffee consisting of Espresso coffee and milk. Basically, Latte is like milk coffee but sweeter. A properly mixed Latte Macchiato must consist of 3 distinct layers, poured in the prescribed order and not mixed together; includes: milk is poured into the first cup, at the bottom of the cup, creating the lowest white layer; then milk powder on the top layer; Finally, pour Espresso through the milk foam layer to the second layer. Sprinkle on the milk foam layer with a little cocoa powder, chocolate or cinnamon powder to decorate and you are done.',
      productImage:
          'https://mediamart.vn/images/uploads/data-2022/ghj-x1KMG4.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Cafe Mocha',
      productPrice: '27.0',
      productCategory: 'Coffees',
      productDescription:
          'Coffee Mocha is a mixture of Espresso coffee mixed with steam and hot chocolate. The characteristics of this drink are the rich aroma of fresh cream and the rich taste of hot chocolate. Pour Espresso mixed with hot milk chocolate powder directly into the center of the cup gently and carefully so as not to break the delicious layer of coffee. Finally, decorate the surface with cocoa powder or chocolate.',
      productImage:
          'https://mediamart.vn/images/uploads/data-2022/ghj-BCe85n.jpg',
      productQuantity: '20',
    ),
//Drinks
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Wine',
      productPrice: '58.0',
      productCategory: 'Drinks',
      productDescription:
          'There are many types of wine, of which wine made from grapes is always loved by Americans. This wine attracts tourists because of its eye-catching purple color and luxurious bottle. Enjoying this wonderful drink with your family during a trip to the US is an ideal choice.',
      productImage:
          'https://dulichmy.com.vn/wp-content/uploads/2021/11/nhung-thuc-uong-1.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Whisky wine',
      productPrice: '18.0',
      productCategory: 'Drinks',
      productDescription:
          'In American cuisine, wine plays an important role. Americans often tend to try pairing similar or contrasting wines and dishes to get new taste experiences. Among the wines of the "Land of Flowers", Whiskey is quite popular. Whiskey in the US also has many types such as: Jim Beam, Labrot & Graham, Wild Turkey, Bernheim Original, Four Roses, Buffalo Trace, Jack Daniel is, George Dickel.',
      productImage:
          'https://dulichmy.com.vn/wp-content/uploads/2021/11/nhung-thuc-uong-17.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Cocktail',
      productPrice: '48.0',
      productCategory: 'Drinks',
      productDescription:
          'Cocktail is a drink consisting of wine mixed with wine, or with fruit juice or carbonated water. Initially, people used some crushed aromatic leaves or lemon juice to drink with wine to add a pleasant flavor. Gradually, due to the need for diversification, this drink was mixed with many different drinks to into cocktails.',
      productImage:
          'https://dulichmy.com.vn/wp-content/uploads/2021/11/nhung-thuc-uong-2-1.jpg',
      productQuantity: '20',
    ),
    //Salads
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Squid salad',
      productPrice: '11.0',
      productCategory: 'Salads',
      productDescription:
          'Squid salad with simple preparation but brings great flavor and is extremely refreshing, eye-catching color, added with a faint aroma from roasted sesame, sweet and crispy vegetables mixed with the crunchiness from fried squid. attractive. When eating salad, you sprinkle a little sauce on it to create a harmonious sour taste, helping to add flavor to our salad.',
      productImage: 'https://cdn.tgdd.vn/2021/04/content/r2-800x500-1.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Scallop salad',
      productPrice: '38.0',
      productCategory: 'Salads',
      productDescription:
          'Add to the menu an extremely attractive, delicious and nutritious scallop salad to make the meal no longer boring. A unique dish with a unique combination of extremely fresh seafood and vegetables. When you eat it, you will feel the fresh taste of the scallops, slowly the mild spiciness of the chili and the sour taste of the tomatoes will melt on the tip of your tongue. This salad not only satisfies the taste buds but is also very beautiful with red and green colors mixed together.',
      productImage: 'https://cdn.tgdd.vn/2021/04/content/r3-800x500-1.jpg',
      productQuantity: '20',
    ),
    //Spaghetti
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Linguine',
      productPrice: '108.0',
      productCategory: 'Spaghettis',
      productDescription:
          'If Spaghetti noodles are thick and round, Linguine noodles are long but thin, rolled flat so they are wider. Because they are rolled thinly, in Italian they also mean "little tongues". Linguine has a slightly lighter taste than Spaghetti, suitable for preparing with seafood dishes, mixed with white wine sauce and clams or mussels. In addition, you can try combining Linguine with traditional cream-based sauces or pesto sauces,',
      productImage:
          'https://images.themodernproper.com/billowy-turkey/production/posts/2022/Linguine-witih-Lemon-Garlic-Sauce-6.jpeg?w=960&h=720&q=82&fm=jpg&fit=crop&dm=1648430386&s=2abdd268813508159ade06a518d98d75',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Cannelloni',
      productPrice: '208.0',
      productCategory: 'Spaghettis',
      productDescription:
          'Cannelloni are sheets of pasta. To make it easier to imagine, you can compare them to crepes, which are then rolled into tubes. The inside of the tube is hollow so that when processing, you can stuff it with filling. Common fillings used include beef, ricotta cheese, spinach... The cannelloni is then covered with light sauces such as tomato or cream before being grilled deliciously.',
      productImage:
          'https://www.southernliving.com/thmb/cKu-8mquQ6QIyO1zqEuV9kKIlHw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chicken-cannelloni-with-roasted-red-bell-pepper-sauce_batch7335_3x2-136-abe48c9f40e04ea8a2abe4b98b4038b1.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Penne',
      productPrice: '408.0',
      productCategory: 'Spaghetti',
      productDescription:
          'Penne is also a type of spaghetti with a round, hollow cylindrical structure, cut diagonally at both ends in many different sizes. The Penne surface can be smooth or ribbed to easily hold thick or creamy sauces on top.',
      productImage:
          'https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/c1082b98-ce28-44db-902f-d634925c7b88/Derivates/ae1c2fdf-d344-4897-831c-a96046065320.jpg',
      productQuantity: '20',
    ),
    //Ice Cream
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Gelato ice cream, Italy',
      productPrice: '50.0',
      productCategory: 'Ice Creams',
      productDescription:
          'Considered one of the most delicious ice creams in the world, Gelato has a smooth, creamy texture but is not greasy. Gelato is diverse flavors will surely satisfy every diner.',
      productImage:
          'https://gcs.tripi.vn/public-tripi/tripi-feed/img/473637BvK/kem-gelato-y-62623.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'Helado Ice Cream, Argentina',
      productPrice: '188.0',
      productCategory: 'Ice Creams',
      productDescription:
          'The special thing about Helado is that it does not use preservatives, maintaining its attractive freshness. If you are a lover of fresh ice cream, enjoy the unique and delicious flavors of Helado Ice Cream. From traditional ice cream like milk, coconut, chocolate, green tea to unique flavors like coffee, red bean, lemon butter, mango, jackfruit,...',
      productImage:
          'https://gcs.tripi.vn/public-tripi/tripi-feed/img/473637WZF/kem-helado-argentina-62653.jpg',
      productQuantity: '20',
    ),
    //SandWiches
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'egg sandwich',
      productPrice: '39.0',
      productCategory: 'Sandwiches',
      productDescription:
          'The egg sandwich is fragrantly fried with a beautiful golden color. The slice of cake is crispy on the outside, soft and chewy on the inside with the rich, fatty taste of eggs. Served with a little lettuce and tomato, it is enough energy for the new day.',
      productImage:
          'https://www.foodnetwork.com/content/dam/images/food/fullset/2016/11/3/2/NLV-Crave-Worthy_breakfast-sandwich_s4x3.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'tuna sandwich',
      productPrice: '39.0',
      productCategory: 'Sandwiches',
      productDescription:
          'The sandwich is decorated with an eye-catching appearance. When you eat it, you will feel the chewy and soft taste of the bread mixed with delicious fatty tuna, sweet meat, soaked in extremely delicious spices.',
      productImage:
          'https://whisperofyum.com/wp-content/uploads/2023/03/easy-tuna-sandwich-recipe.jpg',
      productQuantity: '20',
    ),
    ProductsModels(
      productId: const Uuid().v4(),
      productTitle: 'chicken sandwich',
      productPrice: '90.0',
      productCategory: 'Sandwiches',
      productDescription:
          'The outside slice of bread is evenly coated with a rich, fragrant mayonnaise sauce. Inside is a soft, chewy chicken filling, sweet and juicy without being dry, rich in spices, and served with a little chili sauce or tomato sauce, there is nothing more appealing than that.',
      productImage:
          'https://static01.nyt.com/images/2021/07/06/dining/yk-muhammara-chicken-sandwiches/merlin_189026502_58171dd4-b0bc-47c3-aa6a-d910a3f1de4c-superJumbo.jpg',
      productQuantity: '20',
    ),
  ];
}
