import 'package:BirJol/domain/models/user_model.dart';
import 'package:BirJol/domain/models/ride_model.dart';
import 'package:BirJol/application/providers/app_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatTabScreen extends StatefulWidget {
  const ChatTabScreen({super.key});

  @override
  State<ChatTabScreen> createState() => _ChatTabScreenState();
}

class _ChatTabScreenState extends State<ChatTabScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text(
        'Чаты',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Color(0xFF00D4AA),
          ),
          onPressed: () {
            // TODO: Implement chat search
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.more_vert,
            color: Color(0xFF00D4AA),
          ),
          onPressed: () {
            // TODO: Show chat options
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    final appState = Provider.of<AppStateProvider>(context);
    final currentUser = appState.currentUser;

    if (currentUser == null) {
      return _buildLoginPrompt();
    }

    final chats = _getMockChats(currentUser);

    if (chats.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return _buildChatTile(chat);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: Color(0xFF00D4AA),
              size: 60,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Войдите в аккаунт',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Чтобы начать общение с водителями\nи пассажирами',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D4AA),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Войти',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: Color(0xFF00D4AA),
              size: 60,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Нет активных чатов',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Забронируйте поездку, чтобы\nначать общение',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Navigate to search screen
              Navigator.pushNamed(context, '/search_screen');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D4AA),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Найти поездку',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(ChatData chat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: chat.hasUnreadMessages 
              ? const Color(0xFF00D4AA).withOpacity(0.3)
              : const Color(0xFF2A2A2A),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: _buildAvatar(chat.otherUser),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chat.otherUser.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (chat.hasUnreadMessages)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00D4AA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${chat.unreadCount}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              chat.lastMessage,
              style: TextStyle(
                color: chat.hasUnreadMessages ? Colors.white : Colors.grey[400],
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.grey[600],
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatTime(chat.lastMessageTime),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                if (chat.ride != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D4AA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF00D4AA).withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      '${chat.ride!.price} ₽',
                      style: const TextStyle(
                        color: Color(0xFF00D4AA),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        onTap: () => _openChat(chat),
      ),
    );
  }

  Widget _buildAvatar(UserModel user) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF00D4AA),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          user.name[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _openChat(ChatData chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(chat: chat),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return DateFormat('dd.MM').format(time);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}ч назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}м назад';
    } else {
      return 'Сейчас';
    }
  }

  List<ChatData> _getMockChats(UserModel currentUser) {
    // Mock data for demonstration
    return [
      ChatData(
        id: '1',
        currentUser: currentUser,
        otherUser: UserModel(
          id: 'driver1',
          name: 'Nurel B.',
          email: 'nurel@example.com',
          rating: 4.8,
          totalRides: 156,
          carModel: 'Toyota Camry',
          isDriver: true,
          isVerified: true,
          createdAt: DateTime.now().subtract(const Duration(days: 365)),
        ),
        lastMessage: 'Привет! Я буду через 10 минут. Где вас забрать?',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        hasUnreadMessages: true,
        unreadCount: 2,
        ride: RideModel(
          id: 'ride1',
          driver: UserModel(
            id: 'driver1',
            name: 'Nurel B.',
            email: 'nurel@example.com',
            rating: 4.8,
            totalRides: 156,
            carModel: 'Toyota Camry',
            isDriver: true,
            isVerified: true,
            createdAt: DateTime.now().subtract(const Duration(days: 365)),
          ),
          passengers: [currentUser],
          from: Location(
            latitude: 42.8746,
            longitude: 74.5698,
            address: 'Бишкек, ул. Советская, 123',
          ),
          to: Location(
            latitude: 42.8846,
            longitude: 74.5798,
            address: 'Бишкек, ул. Чуй, 456',
          ),
          departureTime: DateTime.now().add(const Duration(hours: 2)),
          price: 250,
          availableSeats: 2,
          totalSeats: 4,
          rideType: RideType.comfort,
          status: RideStatus.booked,
          createdAt: DateTime.now(),
        ),
      ),
      ChatData(
        id: '2',
        currentUser: currentUser,
        otherUser: UserModel(
          id: 'driver2',
          name: 'Ibrash I.',
          email: 'ibrash@example.com',
          rating: 4.9,
          totalRides: 89,
          carModel: 'Honda Civic',
          isDriver: true,
          isVerified: true,
          createdAt: DateTime.now().subtract(const Duration(days: 200)),
        ),
        lastMessage: 'Спасибо за поездку! Было приятно познакомиться.',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        hasUnreadMessages: false,
        unreadCount: 0,
        ride: null,
      ),
    ];
  }
}

class ChatData {
  final String id;
  final UserModel currentUser;
  final UserModel otherUser;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool hasUnreadMessages;
  final int unreadCount;
  final RideModel? ride;

  ChatData({
    required this.id,
    required this.currentUser,
    required this.otherUser,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.hasUnreadMessages,
    required this.unreadCount,
    this.ride,
  });
}

class ChatDetailScreen extends StatefulWidget {
  final ChatData chat;

  const ChatDetailScreen({
    super.key,
    required this.chat,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<MessageData> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    // Mock messages
    _messages.addAll([
      MessageData(
        id: '1',
        sender: widget.chat.otherUser,
        text: 'Привет! Я буду через 10 минут. Где вас забрать?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        isFromCurrentUser: false,
      ),
      MessageData(
        id: '2',
        sender: widget.chat.currentUser,
        text: 'Привет! Я на остановке "Центр". Буду ждать.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
        isFromCurrentUser: true,
      ),
      MessageData(
        id: '3',
        sender: widget.chat.otherUser,
        text: 'Отлично! Я в белой Toyota Camry. Подъеду через 5 минут.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isFromCurrentUser: false,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          if (widget.chat.ride != null) _buildRideInfo(),
          Expanded(
            child: _buildMessagesList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF0A0A0A),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF00D4AA),
            child: Text(
              widget.chat.otherUser.name[0],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.otherUser.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.chat.otherUser.isDriver ? 'Водитель' : 'Пассажир',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.phone, color: Color(0xFF00D4AA)),
          onPressed: () {
            // TODO: Implement call functionality
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Color(0xFF00D4AA)),
          onPressed: () {
            // TODO: Show chat options
          },
        ),
      ],
    );
  }

  Widget _buildRideInfo() {
    final ride = widget.chat.ride!;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00D4AA).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00D4AA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.directions_car,
              color: Color(0xFF00D4AA),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ride.from.address} → ${ride.to.address}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${ride.price} ₽ • ${DateFormat('dd.MM в HH:mm').format(ride.departureTime)}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.location_on,
              color: Color(0xFF00D4AA),
            ),
            onPressed: () {
              // TODO: Show ride on map
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(MessageData message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isFromCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isFromCurrentUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFF00D4AA),
              child: Text(
                message.sender.name[0],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isFromCurrentUser
                    ? const Color(0xFF00D4AA)
                    : const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomLeft: message.isFromCurrentUser
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: message.isFromCurrentUser
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isFromCurrentUser ? Colors.black : Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('HH:mm').format(message.timestamp),
                    style: TextStyle(
                      color: message.isFromCurrentUser
                          ? Colors.black.withOpacity(0.7)
                          : Colors.grey[400],
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isFromCurrentUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFF00D4AA),
              child: Text(
                message.sender.name[0],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        border: Border(
          top: BorderSide(color: Color(0xFF2A2A2A)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF2A2A2A)),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Написать сообщение...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF00D4AA),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.black,
              ),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = MessageData(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: widget.chat.currentUser,
      text: _messageController.text.trim(),
      timestamp: DateTime.now(),
      isFromCurrentUser: true,
    );

    setState(() {
      _messages.add(newMessage);
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate reply after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final reply = MessageData(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          sender: widget.chat.otherUser,
          text: 'Получил ваше сообщение!',
          timestamp: DateTime.now(),
          isFromCurrentUser: false,
        );

        setState(() {
          _messages.add(reply);
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

class MessageData {
  final String id;
  final UserModel sender;
  final String text;
  final DateTime timestamp;
  final bool isFromCurrentUser;

  MessageData({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
    required this.isFromCurrentUser,
  });
}