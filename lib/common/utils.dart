String iso8601ToTimeFormat(String isoString) {
  final match =
      RegExp(r"PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?").firstMatch(isoString);
  if (match == null) {
    throw ArgumentError("Invalid ISO 8601 duration format: $isoString");
  }

  final hours = int.tryParse(match.group(1) ?? "0") ?? 0;
  final minutes = int.tryParse(match.group(2) ?? "0") ?? 0;
  final seconds = int.tryParse(match.group(3) ?? "0") ?? 0;

  return hours > 0
      ? "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}"
      : "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}
