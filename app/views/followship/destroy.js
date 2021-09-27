$(function () {
  $("#folow-btn").show();
  $("#request-btn").show();
  $("#unfolow-btn").hide();
  let num = parseInt($("#follower-count b").text());
  $("#follower-count b").text(num - 1);
});
