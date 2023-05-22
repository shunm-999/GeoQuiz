// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overpass_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _OverpassClient implements OverpassClient {
  _OverpassClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://overpass-api.de/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OverpassResponse> fetchGeoElements({required data}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'data': data};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OverpassResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/interpreter',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OverpassResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
