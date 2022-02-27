$(document).on('turbolinks:load', function () {

  //\nは"改行"に変換して2文字にする。オプションフラグgで文字列の最後まで\nを探し変換する
  var count = $(".js-text").text().replace(/\n/g, "改行").length;
  var now_count = 140 - count;

  if (count > 140) {
    $(".js-text-count").css("color","red");
  }
 
  $(".js-text-count").text( "残り" + now_count + "文字");

  $(".js-text").on("keyup", function() {
    // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = 140 - count;

    if (count > 140) {
      $(".js-text-count").css("color","red");
    } else {
      $(".js-text-count").css("color","black");
    }
    $(".js-text-count").text( "残り" + now_count + "文字");
  });
});