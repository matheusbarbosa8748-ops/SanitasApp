import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/health_controller.dart';
import '../../models/notification_model.dart';
import '../../widgets/custom_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  final HealthController controller;

  const NotificationsScreen({
    super.key,
    required this.controller,
  });

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'exam':
        return Icons.assignment_turned_in;
      case 'appointment':
        return Icons.calendar_month;
      case 'reminder':
        return Icons.notifications_active;
      default:
        return Icons.info_outline;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'exam':
        return Colors.teal.shade700;
      case 'appointment':
        return Colors.blue.shade700;
      case 'reminder':
        return Colors.orange.shade800;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifications = controller.notifications;
    final unreadCount = controller.unreadNotificationsCount;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notificações',
        controller: controller,
      ),
      body: Column(
        children: [
          // Barra de ações superiores
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.teal.shade50.withOpacity(0.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications_none, color: Colors.teal.shade900, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      unreadCount > 0 ? '$unreadCount não lida(s)' : 'Todas lidas',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),
                  ],
                ),
                if (unreadCount > 0)
                  TextButton.icon(
                    onPressed: () {
                      controller.markAllNotificationsAsRead();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Todas as notificações foram marcadas como lidas.',
                            style: GoogleFonts.poppins(fontSize: 15),
                          ),
                          backgroundColor: Colors.teal.shade800,
                        ),
                      );
                    },
                    icon: const Icon(Icons.done_all, size: 20),
                    label: Text(
                      'Marcar todas lidas',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Lista de Notificações
          Expanded(
            child: notifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'Nenhuma notificação no momento.',
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = notifications[index];
                      final iconColor = _getNotificationColor(item.type);

                      return Card(
                        elevation: item.isRead ? 1 : 3,
                        color: item.isRead ? Colors.white : Colors.teal.shade50.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: item.isRead ? Colors.grey.shade300 : Colors.teal.shade300,
                            width: item.isRead ? 1 : 1.5,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            if (!item.isRead) {
                              controller.markNotificationAsRead(item.id);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: iconColor.withOpacity(0.15),
                                  child: Icon(_getNotificationIcon(item.type), color: iconColor, size: 26),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.title,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          if (!item.isRead)
                                            Container(
                                              margin: const EdgeInsets.only(left: 8),
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.teal.shade700,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                'NOVA',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.message,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.formattedTime,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
