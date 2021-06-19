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

// タブの切り変え
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