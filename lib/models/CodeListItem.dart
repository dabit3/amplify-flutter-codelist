/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the CodeListItem type in your schema. */
@immutable
class CodeListItem extends Model {
  static const classType = const CodeListItemType();
  final String id;
  final String title;
  final String description;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const CodeListItem._internal(
      {@required this.id, @required this.title, this.description});

  factory CodeListItem(
      {String id, @required String title, String description}) {
    return CodeListItem._internal(
        id: id == null ? UUID.getUUID() : id,
        title: title,
        description: description);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CodeListItem &&
        id == other.id &&
        title == other.title &&
        description == other.description;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("CodeListItem {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$title" + ", ");
    buffer.write("description=" + "$description");
    buffer.write("}");

    return buffer.toString();
  }

  CodeListItem copyWith({String id, String title, String description}) {
    return CodeListItem(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description);
  }

  CodeListItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'description': description};

  static final QueryField ID = QueryField(fieldName: "codeListItem.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CodeListItem";
    modelSchemaDefinition.pluralName = "CodeListItems";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CodeListItem.TITLE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CodeListItem.DESCRIPTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class CodeListItemType extends ModelType<CodeListItem> {
  const CodeListItemType();

  @override
  CodeListItem fromJson(Map<String, dynamic> jsonData) {
    return CodeListItem.fromJson(jsonData);
  }
}
