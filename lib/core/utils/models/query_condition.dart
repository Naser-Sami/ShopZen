import '/core/_core.dart';

// Query Condition Model
class QueryCondition {
  final String field;
  final dynamic value;
  final QueryOperator operator;

  QueryCondition({
    required this.field,
    required this.value,
    this.operator = QueryOperator.isEqualTo,
  });
}
