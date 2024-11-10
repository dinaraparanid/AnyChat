import 'package:any_chat/feature/chat/component/page_data.dart';
import 'package:any_chat/utils/functional.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    required IMap<int, PageData> pages,
    int? currentPage,
    Exception? currentError,
  }) = _ChatState;

  factory ChatState.initial() => ChatState(pages: IMap());

  static const undefinedPosition = -1;
}

extension Properties on ChatState {
  int? get nextPage => currentPage?.let((p) => pages[p]?.nextPage);
  int? get previousPage => currentPage?.let((p) => pages[p]?.previousPage);

  bool get mustLoadNextPage => nextPage?.let(mustLoadPage) ?? false;
  bool get mustLoadPreviousPage => previousPage?.let(mustLoadPage) ?? false;

  bool mustLoadPage(int page) =>
    pages[page]?.messages.isEmpty != false;
}
