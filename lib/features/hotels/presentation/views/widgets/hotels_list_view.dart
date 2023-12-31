import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:seasons/core/resources_manager/delay_manager.dart';
import 'package:seasons/features/hotels/presentation/cubit/hotel_cubit/hotel_cubit.dart';
import 'package:seasons/features/hotels/presentation/cubit/hotel_cubit/hotel_states.dart';
import 'package:seasons/features/hotels/presentation/views/widgets/hotels_list_item.dart';

import '../hotel_details_view.dart';
import '../hotels_passenger_data.dart';

class HotelsListView extends StatefulWidget {
  const HotelsListView({Key? key, required this.showAll }) : super(key: key);
  final bool showAll;

  @override
  State<HotelsListView> createState() => _HotelsListViewState();
}

class _HotelsListViewState extends State<HotelsListView> {
  bool hasSingle = false;
  bool hasDouble = false;
  bool hasTriple = false;
  bool hasChildBed = false;
  bool hasChildNoBed = false;
  bool hasInfants = false;
  int adultsSingle=0;
  int adultsDouble=0;
  int adultsTriple=0;
  int kidsWithBed=0;
  int kidsWithNoBed=0;
  int infants=0;
  @override
  void initState() {

    for(int i=0; i<HotelsCubit.get(context).roomsData.length;i++)
    {
      print('object');
      //adultsSingle += ProgramsCubit.get(context).roomsData[i].adults;
      kidsWithBed += HotelsCubit.get(context).roomsData[i].kidsWithBed;
      kidsWithNoBed += HotelsCubit.get(context).roomsData[i].kidsWithNoBed;
      infants += HotelsCubit.get(context).roomsData[i].infants;
      if(HotelsCubit.get(context).roomsData[i].adults==1)
      {
        hasSingle = true;
        adultsSingle++;
      }
      else if(HotelsCubit.get(context).roomsData[i].adults==2)
      {
        hasDouble = true;
        adultsDouble+=2;
      }
      else
      {
        adultsTriple+=3;
        hasTriple = true;
      }
      if(HotelsCubit.get(context).roomsData[i].kidsWithBed >0)
      {
        hasChildBed = true;
      }
      if(HotelsCubit.get(context).roomsData[i].kidsWithNoBed >0)
      {
        hasChildNoBed = true;
      }
      if(HotelsCubit.get(context).roomsData[i].infants >0)
      {
        hasInfants = true;
      }
    }

    // HotelsCubit.get(context).roomsData.forEach((element)
    // {
    //   adults += element.adults;
    //   kidsWithBed += element.kidsWithBed;
    //   kidsWithNoBed += element.kidsWithNoBed;
    //   infants += element.infants;
    // });
    // setState(() {});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HotelsCubit, HotelsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HotelsCubit.get(context);
         if(HotelsCubit.get(context).filteredHotels.isEmpty||widget.showAll)
         {
           if (state is ViewHotelsLoadingState ||
               state is ViewCitiesLoadingState ||
               state is ViewCitiesSuccessState) {
             return Padding(
               padding: const EdgeInsets.only(top: 100.0),
               child: Center(
                 child: CircularProgressIndicator(),
               ),
             );
           } else if (state is ViewHotelsErrorState ||
               state is ViewCitiesErrorState) {
             return Padding(
               padding: const EdgeInsets.only(top: 100.0),
               child: Center(
                 child: Text('Sorry, try again later'),
               ),
             );
           } else if (HotelsCubit.get(context)
               .hotels[HotelsCubit.get(context).currentIndex]
               .isEmpty) {
             return Padding(
               padding: const EdgeInsets.only(top: 100.0),
               child: Center(
                 child: Text('Sorry, There is no data yet'),
               ),
             );
           } else
             return Padding(
               padding: const EdgeInsets.only(
                 right: 20.0,
                 left: 20.0,
                 top: 10.0,
               ),
               child: ListView.separated(
                 itemBuilder: (context, index) {
                   // double net =
                   //     (adults * double.parse(HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index].singlePrice!)) +
                   //         (kidsWithBed * double.parse(HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index].childWithBedPrice!)) +
                   //         (kidsWithNoBed * double.parse(HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index].childNoBedPrice!))
                   // ;
                   double net =
                       (adultsSingle * double.parse(HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index].singlePrice!)) +
                       (adultsDouble * double.parse(HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index].doublePrice!)) +
                       (adultsTriple * double.parse(HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index].triplePrice!)) +
                       (kidsWithBed * double.parse(HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index].childWithBedPrice!)) +
                       (kidsWithNoBed * double.parse(HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index].childNoBedPrice!))
                   ;
                   if(HotelsCubit.get(context).endDate.difference(HotelsCubit.get(context).startDate).inDays!=0)
                     net =  net*HotelsCubit.get(context).endDate.difference(HotelsCubit.get(context).startDate).inDays;
                   double total = net+ (net*(double.parse(HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index].tax!)/100));
                   return InkWell(
                   onTap: () {
                     // Get.to(
                     //         () => HotelDetailsView(
                     //         hotel: HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index]),
                     //     transition: DelayManager.transitionToHotelDetails,
                     //     duration: DelayManager.durationTransitionToHotelDetails,
                     //     curve: DelayManager.curveToHotelDetails);
                     Get.to(
                             () => HotelPassengerData(
                                 net: net,
                               total: total,
                             hotelModel: HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index]),
                         transition: DelayManager.transitionToHotelDetails,
                         duration: DelayManager.durationTransitionToHotelDetails,
                         curve: DelayManager.curveToHotelDetails);
                   },
                   child: HotelsListItem2(
                     total: total,
                       hotel: HotelsCubit.get(context).hotels[HotelsCubit.get(context).currentIndex][index]
                   ),
                 );},
                 separatorBuilder: (context, index) => SizedBox(
                   height: 15,
                 ),
                 itemCount: HotelsCubit.get(context)
                     .hotels[HotelsCubit.get(context).currentIndex]
                     .length,
               ),
             );
         }
         else
         {
           if (state is HotelsFilterLoadingState ||
               state is ViewHotelsLoadingState ||
               state is ViewCitiesLoadingState ||
               state is ViewCitiesSuccessState||
               state is ViewHotelsSuccessState
           )
           {
             return Padding(
               padding: const EdgeInsets.only(top: 100.0),
               child: Center(
                 child: CircularProgressIndicator(),
               ),
             );
           }
           else if (state is ViewHotelsErrorState)
           {
             return Padding(
               padding: const EdgeInsets.only(top: 100.0),
               child: Center(
                 child: Text(state.error),
               ),
             );
           }
           else if (state is ViewCitiesErrorState)
           {
             return Padding(
               padding: const EdgeInsets.only(top: 100.0),
               child: Center(
                 child: Text(state.error),
               ),
             );
           }
           else if (state is HotelsFilterErrorState)
           {
             return Padding(
               padding: const EdgeInsets.only(top: 100.0),
               child: Center(
                 child: Text(state.error),
               ),
             );
           }
           else
             return Padding(
               padding: const EdgeInsets.only(
                 right: 20.0,
                 left: 20.0,
                 top: 10.0,
               ),
               child: ListView.separated(
                 itemBuilder: (context, index) {
                   double net =
                       (adultsSingle * double.parse(HotelsCubit.get(context).filteredHotels[index].singlePrice!)) +
                           (adultsDouble * double.parse(HotelsCubit.get(context).filteredHotels[index].doublePrice!)) +
                           (adultsTriple * double.parse(HotelsCubit.get(context).filteredHotels[index].triplePrice!)) +
                           (kidsWithBed * double.parse(HotelsCubit.get(context).filteredHotels[index].childWithBedPrice!)) +
                           (kidsWithNoBed * double.parse(HotelsCubit.get(context).filteredHotels[index].childNoBedPrice!))
                   ;

                   if(HotelsCubit.get(context).endDate.difference(HotelsCubit.get(context).startDate).inDays!=0)
                     net =  net*HotelsCubit.get(context).endDate.difference(HotelsCubit.get(context).startDate).inDays;
                   double total = net+ (net*(double.parse(HotelsCubit.get(context).filteredHotels[index].tax!)/100));

                   return InkWell(
                   onTap: () {
                     // Get.to(
                     //         () => HotelDetailsView(
                     //         hotel: HotelsCubit.get(context).filteredHotels[index]),
                     //     transition: DelayManager.transitionToHotelDetails,
                     //     duration: DelayManager.durationTransitionToHotelDetails,
                     //     curve: DelayManager.curveToHotelDetails);
                     Get.to(
                             () => HotelPassengerData(
                               net: net,
                               total: total,
                             hotelModel: HotelsCubit.get(context).filteredHotels[index]),
                         transition: DelayManager.transitionToHotelDetails,
                         duration: DelayManager.durationTransitionToHotelDetails,
                         curve: DelayManager.curveToHotelDetails);
                   },
                   child: HotelsListItem2(
                      total: total,
                       hotel: HotelsCubit.get(context).filteredHotels[index]),
                 );},
                 separatorBuilder: (context, index) => SizedBox(
                   height: 15,
                 ),
                 itemCount: HotelsCubit.get(context)
                     .filteredHotels.length,
               ),
             );
         }
        });
  }
}
