/// https://stackoverflow.com/a/78931094/10867055
Iterable<String> getUrls(String input) => RegExp(
  r'(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])',
).allMatches(input).map((match) => match.group(0)).nonNulls;

void main() {
  getUrls(input).forEach(print);
}

// Text from the original poster
const input = '''
window.urlVideo = 'https://node34.vidstreamcdn.com/hls/5d59908aea5aa101a054dec2a1cd3aff/5d59908aea5aa101a054dec2a1cd3aff.playlist.m3u8';
var playerInstance = jwplayer("myVideo");
var countplayer = 1;
var countcheck = 0;
playerInstance.setup({
    sources: [{
        "file": urlVideo
    }],
    tracks: [{
        file: "https://cache.cdnfile.info/images/13f9ddcaf2d83d846056ec44b0f1366d/12.vtt",
        kind: "thumbnails"
    }],
    image: "https://cache.cdnfile.info/images/13f9ddcaf2d83d846056ec44b0f1366d/12_cover.jpg",
});

function changeLink() {
    window.location = "//vidstreaming.io/load.php?id=MTM0OTgz&title=Mairimashita%21+Iruma-kun+Episode+12";
}
window.shouldChangeLink = function () {
    window.location = "//vidstreaming.io/load.php?id=MTM0OTgz&title=Mairimashita%21+Iruma-kun+Episode+12";
}
''';
