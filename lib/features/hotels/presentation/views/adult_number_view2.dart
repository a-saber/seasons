import 'package:flutter/material.dart';
import 'package:seasons/core/core_widgets/default_app_bar.dart';
import 'package:seasons/core/local_database/cache_data.dart';
import 'package:seasons/core/local_database/cache_helper_keys.dart';
import 'package:seasons/core/resources_manager/colors_manager.dart';
import 'package:seasons/features/hotels/presentation/cubit/hotel_cubit/hotel_cubit.dart';
import 'package:seasons/features/programs_view/presentation/views/adult_number_view.dart';

class AdultNumberView2 extends StatefulWidget {
  const AdultNumberView2({Key? key, required this.roomsData}) : super(key: key);
  final List<RoomData> roomsData ;

  @override
  State<AdultNumberView2> createState() => _AdultNumberView2State();
}

class _AdultNumberView2State extends State<AdultNumberView2> {
  List<RoomData> roomsData=[] ;
  @override
  void initState() {
    widget.roomsData.forEach((element)
    {
      roomsData.add(RoomData(adults: element.adults, kidsWithBed: element.kidsWithBed,kidsWithNoBed: element.kidsWithNoBed, infants: element.infants));
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, text: CacheData.lang == CacheHelperKeys.keyEN?'Rooms Details':'تفاصيل الغرف',
          action: IconButton(
              onPressed: ()
              {
                HotelsCubit.get(context).roomsDataSetter(roomsData);
                Navigator.pop(context);
              }, icon: Icon(Icons.check))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0,right: 20, left: 20),
          child: Column(
            children:
            [
              Expanded(
                child: ListView.builder(
                    itemCount: roomsData.length,
                    itemBuilder: (context, index)=>
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Row(
                              children: [
                                Text('${CacheData.lang == CacheHelperKeys.keyEN?'Room':'غرفة'} ${index+1}',
                                  style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                if(index!=0)
                                IconButton(onPressed: ()
                                {
                                  setState(() {
                                    roomsData.removeAt(index);
                                  });
                                }, icon: Icon(Icons.close, color: ColorsManager.iconColor))
                              ],
                            ),
                            Divider(),
                            SizedBox(height: 10,),
                            Row(
                              children:
                              [
                                Text('${CacheData.lang == CacheHelperKeys.keyEN?'Adults':'بالغين'} (+12)', style: TextStyle(color: Colors.black,),),
                                Spacer(),

                                if(roomsData[index].adults>1)
                                  ActiveIconBody(
                                    onTap: ()
                                    {
                                      setState(() {
                                        roomsData[index].adults--;
                                      });
                                    },
                                    child: Icon(Icons.remove, size: 15, color: ColorsManager.primaryColor,),
                                  ),

                                if(roomsData[index].adults<=1)
                                  InActiveIconBody(
                                    child: Icon(Icons.remove, size: 15, color: Colors.grey.withOpacity(0.4),),
                                  ),

                                SizedBox(width: 10,),
                                Text('${roomsData[index].adults}'),
                                SizedBox(width: 10,),


                                if(roomsData[index].adults<4)
                                  ActiveIconBody(
                                    onTap: ()
                                    {
                                      setState(() {
                                        roomsData[index].adults++;
                                      });
                                    },
                                    child: Icon(Icons.add, size: 15, color: ColorsManager.primaryColor,),
                                  ),

                                if(roomsData[index].adults==4)
                                  InActiveIconBody(
                                    child: Icon(Icons.add, size: 15, color: Colors.grey.withOpacity(0.4),),
                                  ),

                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children:
                              [
                                Text('${CacheData.lang == CacheHelperKeys.keyEN?'Children With Bed':'اطفال بسرير'} (2-11)', style: TextStyle(color: Colors.black,),),
                                Spacer(),

                                if(roomsData[index].kidsWithBed>0)
                                  ActiveIconBody(
                                    onTap: ()
                                    {
                                      setState(() {
                                        roomsData[index].kidsWithBed--;
                                      });
                                    },
                                    child: Icon(Icons.remove, size: 15, color: ColorsManager.primaryColor,),
                                  ),

                                if(roomsData[index].kidsWithBed<=0)
                                  InActiveIconBody(
                                    child: Icon(Icons.remove, size: 15, color: Colors.grey.withOpacity(0.4),),
                                  ),

                                SizedBox(width: 10,),
                                Text('${roomsData[index].kidsWithBed}'),
                                SizedBox(width: 10,),


                                (roomsData[index].kidsWithBed<2 && roomsData[index].kidsWithBed+roomsData[index].adults<4)?
                                  ActiveIconBody(
                                    onTap: ()
                                    {
                                      setState(() {
                                        roomsData[index].kidsWithBed++;
                                      });
                                    },
                                    child: Icon(Icons.add, size: 15, color: ColorsManager.primaryColor,),
                                  ):

                                  InActiveIconBody(
                                    child: Icon(Icons.add, size: 15, color: Colors.grey.withOpacity(0.4),),
                                  ),

                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children:
                              [
                                Text('${CacheData.lang == CacheHelperKeys.keyEN?'Children without bed':'اطفال بدون سرير'} (2-11)', style: TextStyle(color: Colors.black,),),
                                Spacer(),

                                if(roomsData[index].kidsWithNoBed>0)
                                  ActiveIconBody(
                                    onTap: ()
                                    {
                                      setState(() {
                                        roomsData[index].kidsWithNoBed--;
                                      });
                                    },
                                    child: Icon(Icons.remove, size: 15, color: ColorsManager.primaryColor,),
                                  ),

                                if(roomsData[index].kidsWithNoBed<=0)
                                  InActiveIconBody(
                                    child: Icon(Icons.remove, size: 15, color: Colors.grey.withOpacity(0.4),),
                                  ),

                                SizedBox(width: 10,),
                                Text('${roomsData[index].kidsWithNoBed}'),
                                SizedBox(width: 10,),


                                (roomsData[index].kidsWithNoBed<2 && roomsData[index].kidsWithNoBed+roomsData[index].adults<4)?
                                ActiveIconBody(
                                  onTap: ()
                                  {
                                    setState(() {
                                      roomsData[index].kidsWithNoBed++;
                                    });
                                  },
                                  child: Icon(Icons.add, size: 15, color: ColorsManager.primaryColor,),
                                ):

                                InActiveIconBody(
                                  child: Icon(Icons.add, size: 15, color: Colors.grey.withOpacity(0.4),),
                                ),

                              ],
                            ),

                            SizedBox(height: 15,),
                            Row(
                              children:
                              [
                                Text('${CacheData.lang == CacheHelperKeys.keyEN?'Infants':'رضع'} (0-2)', style: TextStyle(color: Colors.black,),),
                                Spacer(),

                                if(roomsData[index].infants>0)
                                  ActiveIconBody(
                                    onTap: ()
                                    {
                                      setState(() {
                                        roomsData[index].infants--;
                                      });
                                    },
                                    child: Icon(Icons.remove, size: 15, color: ColorsManager.primaryColor,),
                                  ),

                                if(roomsData[index].infants<=0)
                                  InActiveIconBody(
                                    child: Icon(Icons.remove, size: 15, color: Colors.grey.withOpacity(0.4),),
                                  ),

                                SizedBox(width: 10,),
                                Text('${roomsData[index].infants}'),
                                SizedBox(width: 10,),


                                (roomsData[index].infants<2 && roomsData[index].infants+roomsData[index].adults<4)?
                                ActiveIconBody(
                                  onTap: ()
                                  {
                                    setState(() {
                                      roomsData[index].infants++;
                                    });
                                  },
                                  child: Icon(Icons.add, size: 15, color: ColorsManager.primaryColor,),
                                ):

                                InActiveIconBody(
                                  child: Icon(Icons.add, size: 15, color: Colors.grey.withOpacity(0.4),),
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),



                            Divider(),
                            if(index == roomsData.length-1)
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                                child: InkWell(
                                  onTap: ()
                                  {
                                    setState(() {
                                      roomsData.add(RoomData());
                                    });
                                  },
                                  child: Row(
                                    children:
                                    [
                                      Icon(Icons.add, color: ColorsManager.primaryColor,size: 18,),
                                      SizedBox(width: 15,),
                                      Text(
                                        CacheData.lang == CacheHelperKeys.keyEN?
                                        'Add a room':
                                        'إضافة غرفة',
                                        style: TextStyle(color: ColorsManager.primaryColor),)
                                    ],
                                  ),
                                ),
                              )



                          ],
                        )
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}


class ActiveIconBody extends StatelessWidget {
  const ActiveIconBody({Key? key, required this.child, required this.onTap}) : super(key: key);

  final Widget child;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        padding: EdgeInsets.all(3),
        child: child,
      ),
    );
  }
}

class InActiveIconBody extends StatelessWidget {
  const InActiveIconBody({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.25),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: EdgeInsets.all(3),
      child: child,
    );
  }
}
