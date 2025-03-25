import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:ShoppingList(),
    );
  }
}
class ShoppingList extends StatefulWidget{
  @override
  ShoppingListState createState()=>ShoppingListState();
}
class ShoppingListState extends State<ShoppingList>{
  //create variable to store list items
  final List<String>itemsToAdd=[];
  //keep track of text controller
  final TextEditingController itemController=TextEditingController();
  //keep track of index of items
  //so that if there is item to be edited
  //then it is edited based on the index
  int?editingIndex;
  //function to add item to list
  void addItem(){
    setState(() {
      //check if there text field is not empty
      //if not empty
      //check if there is item to be edited
      if(itemController.text.isNotEmpty){
        //check editing index to edit the item based on index
        if(editingIndex==null){
          // add item in the text input field
          itemsToAdd.add(itemController.text);
        }else{
          //after editing the item then add it to the list
          itemsToAdd[editingIndex!]=itemController.text;
          //reset the editing index
          editingIndex=null;
        }

      }

      //clear the input field
      itemController.clear();

    });

  }
  void deleteItems(){
    //clear the item list
    setState(() {
      itemsToAdd.clear();
    });


  }
  void editItems(index){
    setState(() {
      //get the index
      //edit the text
      itemController.text=itemsToAdd[index];
      editingIndex=index;
    });


  }
@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Simple to-do-list Application',style: TextStyle(color: Colors.red,fontSize: 20),),centerTitle: true,),
      body: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        // color: Colors.grey,
        child: Column(
          children: [
            Row(children: [
              Expanded(child: TextField(
                controller: itemController,
                decoration: InputDecoration(
                  hintText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              )),
            ],),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(onPressed:addItem,style:ElevatedButton.styleFrom(backgroundColor: Colors.green),child: Text(editingIndex==null?"Add":"Update"),),),
                    SizedBox(width: 10,),
                    // Expanded(child: ElevatedButton(onPressed:()=>editItems,style:ElevatedButton.styleFrom(backgroundColor: Colors.grey),child: Text(''
                    //     'Edit'),),),
                    SizedBox(width: 10,),
                    Expanded(child: ElevatedButton(onPressed:deleteItems,style:ElevatedButton.styleFrom(backgroundColor: Colors.red),child: Text(''
                        'Clear item list'),),),
                  ],
                ),

                Expanded(child: ListView.builder(
                  itemCount: itemsToAdd.length,

                    itemBuilder:(context,index){
return ListTile(title: Text(itemsToAdd[index]),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [

    IconButton(onPressed:()=>editItems(index), icon:Icon(Icons.edit,color: Colors.blue,)),
    IconButton(onPressed:(){
      setState(() {
        itemsToAdd.removeAt(index);
      });
    }, icon:Icon(Icons.delete,color: Colors.grey,)),
  ],),


);
                })),

          ],
        ),
      ),
    );
}

}