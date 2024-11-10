import 'package:any_chat/domain/chat/message.dart';
import 'package:any_chat/utils/paging/pager.dart';

export 'package:any_chat/utils/paging/pager.dart';

abstract class ChatPagingSource extends PagingSource<int, Message> {}
