import 'dart:convert';
import 'dart:developer' as dev;

import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer';

class SupabaseWebSocketService {
  final SupabaseClient supabase;

  SupabaseWebSocketService(this.supabase);

  void unsubscribe(String tableName) {
    supabase.channel('public:$tableName').unsubscribe();
    dev.log("Unsubscribed from table: $tableName");
  }

  Future<void> insert(String tableName, Map<String, dynamic> data) async {
    try {
      await supabase.from(tableName).insert(data);
      dev.log("✅ Inserted into $tableName: ${jsonEncode(data)}");
    } catch (e) {
      dev.log("❌ Error inserting: ${e.toString()}");
    }
  }

  Future<void> update(String tableName, Map<String, dynamic> data,
      String column, dynamic value) async {
    try {
      await supabase.from(tableName).update(data).eq(column, value);
      dev.log(
          "🔄 Updated $tableName where $column = $value: ${jsonEncode(data)}");
    } catch (e) {
      dev.log("❌ Error updating: ${e.toString()}");
    }
  }

  Future<void> delete(String tableName, String column, dynamic value) async {
    try {
      await supabase.from(tableName).delete().eq(column, value);
      dev.log("🗑️ Deleted from $tableName where $column = $value");
    } catch (e) {
      dev.log("❌ Error deleting: ${e.toString()}");
    }
  }

  void listenToTable({
    required String tableName,
    required void Function(PostgresChangePayload payload) onDataChanged,
  }) {
    supabase
        .channel('public:$tableName')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: tableName,
          callback: onDataChanged,
        )
        .subscribe();
  }

  void listenToInsert({
    required String tableName,
    required void Function(Map<String, dynamic> newRecord) onInsert,
  }) {
    supabase
        .channel('public:$tableName')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: tableName,
          callback: (payload) {
            log("🆕 Inserted: ${payload.newRecord}");
            onInsert(payload.newRecord);
          },
        )
        .subscribe();
  }

  void listenToUpdate({
    required String tableName,
    required void Function(
            Map<String, dynamic> oldRecord, Map<String, dynamic> newRecord)
        onUpdate,
  }) {
    supabase
        .channel('public:$tableName')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: tableName,
          callback: (payload) {
            log("✏️ Updated: ${payload.newRecord}");
            log("🔙 Previous Data: ${payload.oldRecord}");
            onUpdate(payload.oldRecord, payload.newRecord);
          },
        )
        .subscribe();
  }

  void listenToDelete({
    required String tableName,
    required void Function(Map<String, dynamic> oldRecord) onDelete,
  }) {
    supabase
        .channel('public:$tableName')
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: tableName,
          callback: (payload) {
            log("❌ Deleted: ${payload.oldRecord}");
            onDelete(payload.oldRecord);
          },
        )
        .subscribe();
  }

  Future<List<Map<String, dynamic>>> getData(
      String tableName, String column, dynamic value) async {
    try {
      final response =
          await supabase.from(tableName).select().eq(column, value);
      dev.log(
          "📊 Retrieved from $tableName where $column = $value: ${jsonEncode(response)}");
      return response;
    } catch (e) {
      dev.log("❌ Error fetching data: ${e.toString()}");
      return [];
    }
  }
}
