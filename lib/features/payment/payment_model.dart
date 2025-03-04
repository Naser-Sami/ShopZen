import 'package:equatable/equatable.dart';

class PaymentModel extends Equatable {
  const PaymentModel({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountDetails,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    this.captureMethod,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.lastPaymentError,
    this.latestCharge,
    this.livemode,
    this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  final String? id;
  final String? object;
  final num? amount;
  final num? amountCapturable;
  final AmountDetails? amountDetails;
  final num? amountReceived;
  final dynamic application;
  final dynamic applicationFeeAmount;
  final AutomaticPaymentMethods? automaticPaymentMethods;
  final dynamic canceledAt;
  final dynamic cancellationReason;
  final String? captureMethod;
  final String? clientSecret;
  final String? confirmationMethod;
  final num? created;
  final String? currency;
  final dynamic customer;
  final dynamic description;
  final dynamic invoice;
  final dynamic lastPaymentError;
  final dynamic latestCharge;
  final bool? livemode;
  final Metadata? metadata;
  final dynamic nextAction;
  final dynamic onBehalfOf;
  final dynamic paymentMethod;
  final PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;
  final PaymentMethodOptions? paymentMethodOptions;
  final List<String>? paymentMethodTypes;
  final dynamic processing;
  final dynamic receiptEmail;
  final dynamic review;
  final dynamic setupFutureUsage;
  final dynamic shipping;
  final dynamic source;
  final dynamic statementDescriptor;
  final dynamic statementDescriptorSuffix;
  final String? status;
  final dynamic transferData;
  final dynamic transferGroup;

  PaymentModel copyWith({
    String? id,
    String? object,
    num? amount,
    num? amountCapturable,
    AmountDetails? amountDetails,
    num? amountReceived,
    dynamic application,
    dynamic applicationFeeAmount,
    AutomaticPaymentMethods? automaticPaymentMethods,
    dynamic canceledAt,
    dynamic cancellationReason,
    String? captureMethod,
    String? clientSecret,
    String? confirmationMethod,
    num? created,
    String? currency,
    dynamic customer,
    dynamic description,
    dynamic invoice,
    dynamic lastPaymentError,
    dynamic latestCharge,
    bool? livemode,
    Metadata? metadata,
    dynamic nextAction,
    dynamic onBehalfOf,
    dynamic paymentMethod,
    PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails,
    PaymentMethodOptions? paymentMethodOptions,
    List<String>? paymentMethodTypes,
    dynamic processing,
    dynamic receiptEmail,
    dynamic review,
    dynamic setupFutureUsage,
    dynamic shipping,
    dynamic source,
    dynamic statementDescriptor,
    dynamic statementDescriptorSuffix,
    String? status,
    dynamic transferData,
    dynamic transferGroup,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      object: object ?? this.object,
      amount: amount ?? this.amount,
      amountCapturable: amountCapturable ?? this.amountCapturable,
      amountDetails: amountDetails ?? this.amountDetails,
      amountReceived: amountReceived ?? this.amountReceived,
      application: application ?? this.application,
      applicationFeeAmount: applicationFeeAmount ?? this.applicationFeeAmount,
      automaticPaymentMethods: automaticPaymentMethods ?? this.automaticPaymentMethods,
      canceledAt: canceledAt ?? this.canceledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      captureMethod: captureMethod ?? this.captureMethod,
      clientSecret: clientSecret ?? this.clientSecret,
      confirmationMethod: confirmationMethod ?? this.confirmationMethod,
      created: created ?? this.created,
      currency: currency ?? this.currency,
      customer: customer ?? this.customer,
      description: description ?? this.description,
      invoice: invoice ?? this.invoice,
      lastPaymentError: lastPaymentError ?? this.lastPaymentError,
      latestCharge: latestCharge ?? this.latestCharge,
      livemode: livemode ?? this.livemode,
      metadata: metadata ?? this.metadata,
      nextAction: nextAction ?? this.nextAction,
      onBehalfOf: onBehalfOf ?? this.onBehalfOf,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentMethodConfigurationDetails:
          paymentMethodConfigurationDetails ?? this.paymentMethodConfigurationDetails,
      paymentMethodOptions: paymentMethodOptions ?? this.paymentMethodOptions,
      paymentMethodTypes: paymentMethodTypes ?? this.paymentMethodTypes,
      processing: processing ?? this.processing,
      receiptEmail: receiptEmail ?? this.receiptEmail,
      review: review ?? this.review,
      setupFutureUsage: setupFutureUsage ?? this.setupFutureUsage,
      shipping: shipping ?? this.shipping,
      source: source ?? this.source,
      statementDescriptor: statementDescriptor ?? this.statementDescriptor,
      statementDescriptorSuffix:
          statementDescriptorSuffix ?? this.statementDescriptorSuffix,
      status: status ?? this.status,
      transferData: transferData ?? this.transferData,
      transferGroup: transferGroup ?? this.transferGroup,
    );
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json["id"],
      object: json["object"],
      amount: json["amount"],
      amountCapturable: json["amount_capturable"],
      amountDetails: json["amount_details"] == null
          ? null
          : AmountDetails.fromJson(json["amount_details"]),
      amountReceived: json["amount_received"],
      application: json["application"],
      applicationFeeAmount: json["application_fee_amount"],
      automaticPaymentMethods: json["automatic_payment_methods"] == null
          ? null
          : AutomaticPaymentMethods.fromJson(json["automatic_payment_methods"]),
      canceledAt: json["canceled_at"],
      cancellationReason: json["cancellation_reason"],
      captureMethod: json["capture_method"],
      clientSecret: json["client_secret"],
      confirmationMethod: json["confirmation_method"],
      created: json["created"],
      currency: json["currency"],
      customer: json["customer"],
      description: json["description"],
      invoice: json["invoice"],
      lastPaymentError: json["last_payment_error"],
      latestCharge: json["latest_charge"],
      livemode: json["livemode"],
      metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
      nextAction: json["next_action"],
      onBehalfOf: json["on_behalf_of"],
      paymentMethod: json["payment_method"],
      paymentMethodConfigurationDetails:
          json["payment_method_configuration_details"] == null
              ? null
              : PaymentMethodConfigurationDetails.fromJson(
                  json["payment_method_configuration_details"]),
      paymentMethodOptions: json["payment_method_options"] == null
          ? null
          : PaymentMethodOptions.fromJson(json["payment_method_options"]),
      paymentMethodTypes: json["payment_method_types"] == null
          ? []
          : List<String>.from(json["payment_method_types"]!.map((x) => x)),
      processing: json["processing"],
      receiptEmail: json["receipt_email"],
      review: json["review"],
      setupFutureUsage: json["setup_future_usage"],
      shipping: json["shipping"],
      source: json["source"],
      statementDescriptor: json["statement_descriptor"],
      statementDescriptorSuffix: json["statement_descriptor_suffix"],
      status: json["status"],
      transferData: json["transfer_data"],
      transferGroup: json["transfer_group"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "amount": amount,
        "amount_capturable": amountCapturable,
        "amount_details": amountDetails?.toJson(),
        "amount_received": amountReceived,
        "application": application,
        "application_fee_amount": applicationFeeAmount,
        "automatic_payment_methods": automaticPaymentMethods?.toJson(),
        "canceled_at": canceledAt,
        "cancellation_reason": cancellationReason,
        "capture_method": captureMethod,
        "client_secret": clientSecret,
        "confirmation_method": confirmationMethod,
        "created": created,
        "currency": currency,
        "customer": customer,
        "description": description,
        "invoice": invoice,
        "last_payment_error": lastPaymentError,
        "latest_charge": latestCharge,
        "livemode": livemode,
        "metadata": metadata?.toJson(),
        "next_action": nextAction,
        "on_behalf_of": onBehalfOf,
        "payment_method": paymentMethod,
        "payment_method_configuration_details":
            paymentMethodConfigurationDetails?.toJson(),
        "payment_method_options": paymentMethodOptions?.toJson(),
        "payment_method_types": paymentMethodTypes?.map((x) => x).toList(),
        "processing": processing,
        "receipt_email": receiptEmail,
        "review": review,
        "setup_future_usage": setupFutureUsage,
        "shipping": shipping,
        "source": source,
        "statement_descriptor": statementDescriptor,
        "statement_descriptor_suffix": statementDescriptorSuffix,
        "status": status,
        "transfer_data": transferData,
        "transfer_group": transferGroup,
      };

  @override
  String toString() {
    return "$id, $object, $amount, $amountCapturable, $amountDetails, $amountReceived, $application, $applicationFeeAmount, $automaticPaymentMethods, $canceledAt, $cancellationReason, $captureMethod, $clientSecret, $confirmationMethod, $created, $currency, $customer, $description, $invoice, $lastPaymentError, $latestCharge, $livemode, $metadata, $nextAction, $onBehalfOf, $paymentMethod, $paymentMethodConfigurationDetails, $paymentMethodOptions, $paymentMethodTypes, $processing, $receiptEmail, $review, $setupFutureUsage, $shipping, $source, $statementDescriptor, $statementDescriptorSuffix, $status, $transferData, $transferGroup, ";
  }

  @override
  List<Object?> get props => [
        id,
        object,
        amount,
        amountCapturable,
        amountDetails,
        amountReceived,
        application,
        applicationFeeAmount,
        automaticPaymentMethods,
        canceledAt,
        cancellationReason,
        captureMethod,
        clientSecret,
        confirmationMethod,
        created,
        currency,
        customer,
        description,
        invoice,
        lastPaymentError,
        latestCharge,
        livemode,
        metadata,
        nextAction,
        onBehalfOf,
        paymentMethod,
        paymentMethodConfigurationDetails,
        paymentMethodOptions,
        paymentMethodTypes,
        processing,
        receiptEmail,
        review,
        setupFutureUsage,
        shipping,
        source,
        statementDescriptor,
        statementDescriptorSuffix,
        status,
        transferData,
        transferGroup,
      ];
}

class AmountDetails extends Equatable {
  const AmountDetails({
    this.tip,
  });

  final Metadata? tip;

  AmountDetails copyWith({
    Metadata? tip,
  }) {
    return AmountDetails(
      tip: tip ?? this.tip,
    );
  }

  factory AmountDetails.fromJson(Map<String, dynamic> json) {
    return AmountDetails(
      tip: json["tip"] == null ? null : Metadata.fromJson(json["tip"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "tip": tip?.toJson(),
      };

  @override
  String toString() {
    return "$tip, ";
  }

  @override
  List<Object?> get props => [
        tip,
      ];
}

class Metadata extends Equatable {
  const Metadata({required this.json});
  final Map<String, dynamic> json;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(json: json);
  }

  Map<String, dynamic> toJson() => {};

  @override
  String toString() {
    return "";
  }

  @override
  List<Object?> get props => [];
}

class AutomaticPaymentMethods extends Equatable {
  const AutomaticPaymentMethods({
    this.allowRedirects,
    this.enabled,
  });

  final String? allowRedirects;
  final bool? enabled;

  AutomaticPaymentMethods copyWith({
    String? allowRedirects,
    bool? enabled,
  }) {
    return AutomaticPaymentMethods(
      allowRedirects: allowRedirects ?? this.allowRedirects,
      enabled: enabled ?? this.enabled,
    );
  }

  factory AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) {
    return AutomaticPaymentMethods(
      allowRedirects: json["allow_redirects"],
      enabled: json["enabled"],
    );
  }

  Map<String, dynamic> toJson() => {
        "allow_redirects": allowRedirects,
        "enabled": enabled,
      };

  @override
  String toString() {
    return "$allowRedirects, $enabled, ";
  }

  @override
  List<Object?> get props => [
        allowRedirects,
        enabled,
      ];
}

class PaymentMethodConfigurationDetails extends Equatable {
  const PaymentMethodConfigurationDetails({
    this.id,
    this.parent,
  });

  final String? id;
  final dynamic parent;

  PaymentMethodConfigurationDetails copyWith({
    String? id,
    dynamic parent,
  }) {
    return PaymentMethodConfigurationDetails(
      id: id ?? this.id,
      parent: parent ?? this.parent,
    );
  }

  factory PaymentMethodConfigurationDetails.fromJson(Map<String, dynamic> json) {
    return PaymentMethodConfigurationDetails(
      id: json["id"],
      parent: json["parent"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent": parent,
      };

  @override
  String toString() {
    return "$id, $parent, ";
  }

  @override
  List<Object?> get props => [
        id,
        parent,
      ];
}

class PaymentMethodOptions extends Equatable {
  const PaymentMethodOptions({
    this.card,
    this.link,
  });

  final Card? card;
  final Link? link;

  PaymentMethodOptions copyWith({
    Card? card,
    Link? link,
  }) {
    return PaymentMethodOptions(
      card: card ?? this.card,
      link: link ?? this.link,
    );
  }

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptions(
      card: json["card"] == null ? null : Card.fromJson(json["card"]),
      link: json["link"] == null ? null : Link.fromJson(json["link"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "card": card?.toJson(),
        "link": link?.toJson(),
      };

  @override
  String toString() {
    return "$card, $link, ";
  }

  @override
  List<Object?> get props => [
        card,
        link,
      ];
}

class Card extends Equatable {
  const Card({
    this.installments,
    this.mandateOptions,
    this.network,
    this.requestThreeDSecure,
  });

  final dynamic installments;
  final dynamic mandateOptions;
  final dynamic network;
  final String? requestThreeDSecure;

  Card copyWith({
    dynamic installments,
    dynamic mandateOptions,
    dynamic network,
    String? requestThreeDSecure,
  }) {
    return Card(
      installments: installments ?? this.installments,
      mandateOptions: mandateOptions ?? this.mandateOptions,
      network: network ?? this.network,
      requestThreeDSecure: requestThreeDSecure ?? this.requestThreeDSecure,
    );
  }

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      installments: json["installments"],
      mandateOptions: json["mandate_options"],
      network: json["network"],
      requestThreeDSecure: json["request_three_d_secure"],
    );
  }

  Map<String, dynamic> toJson() => {
        "installments": installments,
        "mandate_options": mandateOptions,
        "network": network,
        "request_three_d_secure": requestThreeDSecure,
      };

  @override
  String toString() {
    return "$installments, $mandateOptions, $network, $requestThreeDSecure, ";
  }

  @override
  List<Object?> get props => [
        installments,
        mandateOptions,
        network,
        requestThreeDSecure,
      ];
}

class Link extends Equatable {
  const Link({
    this.persistentToken,
  });

  final dynamic persistentToken;

  Link copyWith({
    dynamic persistentToken,
  }) {
    return Link(
      persistentToken: persistentToken ?? this.persistentToken,
    );
  }

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      persistentToken: json["persistent_token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "persistent_token": persistentToken,
      };

  @override
  String toString() {
    return "$persistentToken, ";
  }

  @override
  List<Object?> get props => [
        persistentToken,
      ];
}
