import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/place/model/place_model.dart';
import 'package:tago_app/place/provider/place_provider.dart';

class PlaceSearchModal extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final Offset offset;
  final List<PlaceModel> selectedPlaces;
  final Function updatePlaces;

  const PlaceSearchModal(
      {super.key,
      required this.controller,
      required this.selectedPlaces,
      required this.offset,
      required this.updatePlaces});
  @override
  // ignore: library_private_types_in_public_api
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends ConsumerState<PlaceSearchModal> {
  List<PlaceModel> selectedPlacesInModal = [];

  @override
  void initState() {
    if (widget.selectedPlaces.isNotEmpty) {
      selectedPlacesInModal.add(widget.selectedPlaces.first);
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - widget.offset.dy,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        decoration: const BoxDecoration(
          color: LABEL_BG_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            TextField(
              controller: widget.controller,
              onChanged: (value) {
                ref.read(placeProvider.notifier).filterPlaces(value);
              },
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: LABEL_TEXT_SUB_COLOR,
                ),
                hintStyle: TextStyle(
                  color: LABEL_TEXT_SUB_COLOR,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
                hintText: '장소 추가하기',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: PRIMARY_COLOR,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  final state = ref.watch(placeProvider);

                  if (state is CursorPaginationLoading) {
                    return const Center(
                        child: CircularProgressIndicator(color: PRIMARY_COLOR));
                  } else if (state is CursorPaginationError) {
                    return Text('Error: ${state.message}');
                  } else if (state is CursorPagination) {
                    final places = state.contents as List<PlaceModel>;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  places[index].title,
                                ),
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedPlacesInModal
                                            .clear(); //TOFIX: 일단 한개의 place만.
                                        selectedPlacesInModal
                                            .add(places[index]);
                                      });
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return selectedPlacesInModal.isEmpty
                                              ? Colors.white
                                              : selectedPlacesInModal
                                                          .first.id ==
                                                      places[index].id
                                                  ? SELECTED_PLACE_BG_COLOR
                                                  : Colors.white;
                                        },
                                      ),
                                      foregroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return selectedPlacesInModal.isEmpty
                                              ? SELECTED_BOX_BG_COLOR
                                              : selectedPlacesInModal
                                                          .first.id ==
                                                      places[index].id
                                                  ? Colors.white
                                                  : SELECTED_BOX_BG_COLOR;
                                        },
                                      ),
                                      side: MaterialStateProperty.all(
                                        BorderSide.none, // border 제거
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text('No data found.');
                  }
                },
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width, 45)),
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: selectedPlacesInModal.isNotEmpty
                  ? () {
                      widget.updatePlaces(selectedPlacesInModal[0]);
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text(
                '추가하기',
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
