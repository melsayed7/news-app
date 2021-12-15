
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';


Widget defaultButton ({
   double width = double.infinity,
   Color background = Colors.blue,
   bool isUppercase = true ,
   double radius =10.0 ,
   Function()? function,
   required String text ,
}) =>
Container(
   width: width,
  child: MaterialButton(
    onPressed: function ,
    child:  Text(
      isUppercase ? text.toUpperCase() : text ,
      style: TextStyle(fontSize: 30.0, color: Colors.white),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);

Widget defaultTextButton({
  required Function()? function,
  required String text ,
}) =>
TextButton(
  onPressed: function,
  child: Text(text.toUpperCase()),
  );

Widget defaultTextFeild ({
  required TextEditingController controller,
  required TextInputType type ,
  required String label,
  required IconData prefix ,
  required String? Function(String?)? validate ,
  bool isPassword = false,
  IconData? suffix ,
  Function()? suffixPressed ,
  Function()? ontaped ,
  Function(String)? onchange ,
  }) => TextFormField(
  controller: controller,
  keyboardType: type,
  validator: validate,
  onTap: ontaped ,
  onChanged: onchange ,
  obscureText: isPassword ,
  decoration:  InputDecoration(
    prefixIcon: Icon(prefix),
    labelText: label ,
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed ,
        icon: Icon(suffix)) : null ,
    border: OutlineInputBorder(),
  ),
);


Widget myDivider () => Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey[300],
);

Widget buildArticleItem (article , context) => InkWell(
  onTap: (){
    //navigateTO(context, WebViewScreen(article['url']),);
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),



    child: Row(



      children: [



        Container(



          width: 120.0,



          height: 120.0,



          decoration: BoxDecoration(



            borderRadius: BorderRadius.circular(10.0),



            image:DecorationImage(



              image: NetworkImage('${article['urlToImage']}'),



              fit: BoxFit.cover,



            ),



          ),



        ),



        SizedBox(



          width: 18.0,



        ),



        Expanded(



          child: Container(



            height: 120.0,



            child: Column(



              crossAxisAlignment: CrossAxisAlignment.start,



              mainAxisAlignment: MainAxisAlignment.start,



              children: [



                Expanded(



                  child: Text(



                    '${article['title']}',



                    style: Theme.of(context).textTheme.bodyText1,



                    maxLines: 3,



                    overflow: TextOverflow.ellipsis,



                  ),



                ),



                Text(



                  '${article['publishedAt']}',



                  style: TextStyle(



                    color: Colors.grey,



                  ),



                ),



              ],



            ),



          ),



        ),



      ],



    ),



  ),
);

Widget articleBuilder (list,context,{isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index],context) ,
    separatorBuilder: (context, index) => myDivider(),
    itemCount: 20 ,
  ) ,
  fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator(),),
);

void navigateTO( context, widget) =>  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish( context, widget) =>  Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute (
    builder: (context) => widget,
  ),
    (Route<dynamic> route) => false ,
);
