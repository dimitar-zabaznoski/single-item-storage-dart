/// To map converter.
///
/// The value must be either a number, boolean, string, null,
/// list or a map with string keys.
typedef Map<String, dynamic> ToMap<E>(E item);

/// From map converter.
///
/// Should only convert values that are either a number, boolean,
/// string, null, list or a map with string keys.
typedef E FromMap<E>(Map<String, dynamic> map);
