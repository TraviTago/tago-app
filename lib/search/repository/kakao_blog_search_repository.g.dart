// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kakao_blog_search_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _KakaoBlogSearchRepository implements KakaoBlogSearchRepository {
  _KakaoBlogSearchRepository(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PagePagination<KakaoBlogSearchModel>> paginate({
    sort = 'accuracy',
    page = 1,
    size = 10,
    query = "해운대해수욕장 후기",
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sort': sort,
      r'page': page,
      r'size': size,
      r'query': query,
    };
    final _headers = <String, dynamic>{r'kakao': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PagePagination<KakaoBlogSearchModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/blog',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PagePagination<KakaoBlogSearchModel>.fromJson(
      _result.data!,
      (json) => KakaoBlogSearchModel.fromJson(json as Map<String, dynamic>),
    );
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
