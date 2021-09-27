$(function () {
  $("#folow-btn").hide();
  $("#unfolow-btn").show();
  let num = parseInt($("#follower-count b").text());
  $("#follower-count b").text(num + 1);
});
