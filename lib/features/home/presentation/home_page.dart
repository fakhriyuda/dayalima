import 'package:dayagram/core/common/routes.dart';
import 'package:dayagram/features/home/bloc/home_bloc.dart';
import 'package:dayagram/features/home/presentation/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  // pagination
  final _scrollController = ScrollController();

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
      homeBloc.add(LoadMore());
    }
    return false;
  }

  @override
  void initState() {
    homeBloc.add(GetPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dayagram")),
      body: BlocConsumer(
        bloc: homeBloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeSuccess || state is HomeLoadMore) {
            return NotificationListener(
              onNotification: _handleScrollNotification,
              child: Stack(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      var item = homeBloc.listPosts[index];
                      return PostItem(
                        message: item.message,
                        image: item.image,
                        likes: item.likes,
                        id: item.id,
                        videoUrl: item.videoUrl,
                      );
                    },
                    itemCount: homeBloc.listPosts.length,
                  ),
                  (state is HomeLoadMore) ? loadMore() : const SizedBox(),
                ],
              ),
            );
          }
          if (state is HomeError) {
            return Column(
              children: [
                Text("Sorry there's an Error,${state.message}"),
                MaterialButton(
                    color: Colors.blue,
                    child: const Text("Refresh",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      homeBloc.add(GetPosts());
                    }),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context) // variable context
              .pushNamed(Routes.UPLOAD_PAGE);
        },
        tooltip: 'Upload',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget loadMore() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
