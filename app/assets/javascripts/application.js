// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery.jscroll.min.js
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


// 無限スクロールの処理
// ページ下の5%の範囲に来たら発火
// タブと一緒に使うので、とってくるデータをタブで指定
$(window).on('scroll', function() {
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
          $('.box-show > .jscroll').jscroll({
            // 無限スクロールした要素のどこを使うか、tabで今選択されているタブを判断
            contentSelector: $('.box-show > .scroll-list').attr('tab'),
            // 次のページのリンクの場所
            nextSelector: 'span.next:last a'
          });
    }
});

// タブの切り替え
$(document).on('turbolinks:load', function() {
  $(function() {
    $('.tab').click(function(){
      $('.tab-active').removeClass('tab-active');
      $(this).addClass('tab-active');
      $('.box-show').removeClass('box-show');
      const index = $(this).index();
      $('.tabbox').eq(index).addClass('box-show');
    });
  });
});

// 1ページに2つタブ必要な場合
$(document).on('turbolinks:load', function() {
  $(function() {
    $('.tab2').click(function(){
      $('.tab2-active').removeClass('tab2-active');
      $(this).addClass('tab2-active');
      $('.box2-show').removeClass('box2-show');
      const index = $(this).index();
      $('.tabbox2').eq(index).addClass('box2-show');
    });
  });
});

// 1ページに3つタブ必要な場合
$(document).on('turbolinks:load', function() {
  $(function() {
    $('.tab3').click(function(){
      $('.tab3-active').removeClass('tab3-active');
      $(this).addClass('tab3-active');
      $('.box3-show').removeClass('box3-show');
      const index = $(this).index();
      $('.tabbox3').eq(index).addClass('box3-show');
    });
  });
});

// アコーディオンメニュー
$(document).on('turbolinks:load', function() {
  $(function(){
    $('.js-accordion-title').on('click', function () {
      /*クリックでコンテンツを開閉*/
      $(this).next().slideToggle(200);
      /*矢印の向きを変更*/
      $(this).toggleClass('open', 200);
    });
  });
});

// ローディング画面の表示
document.addEventListener('turbolinks:load', function() {
  $(window).on('load',function(){
    $("#loading").delay(1500).fadeOut('slow');//ローディング画面を1.5秒（1500ms）待機してからフェードアウト
    $("#loading_box").delay(1200).fadeOut('slow');//ローディングテキストを1.2秒（1200ms）待機してからフェードアウト
  });
});

// ページトップボタン表示
$(document).on('turbolinks:load', function() {
  $(window).scroll(function () {
    var now = $(window).scrollTop();
    if (now > 2500) {
      $('.pagetop').fadeIn("slow");
    } else {
      $('.pagetop').fadeOut('slow');
    }
  });
});
// ページトップへ戻るクリックで、スクロールして１番上に戻る
$(document).on('turbolinks:load', function() {
  $(function(){
    $('.pagetop').click(function(){
      $('body,html').animate({
      scrollTop: 0},500);
      return false;
    });
  });
});

// スライドショー
$(document).on('turbolinks:load', function(){
  $('.slick').slick({
    autoplay:true,
    dots:true,
    prevArrow: '<i class="fas fa-angle-left"></i>',
    nextArrow: '<i class="fas fa-angle-right"></i>'
  });
});
