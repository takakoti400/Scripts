// ==UserScript==
// @name         DLSite title Copier
// @namespace    https://qiita.com/righteous
// @version      1.0
// @description  Adds an navigation tab on user pages
// @author       tk400
// @match        https://www.dlsite.com/*
// @grant        none
// ==/UserScript==

(function() {
  'use strict';
  window.addEventListener("load", function () {
    var topwrapper = document.querySelector("#top_wrapper [id]")
    if (topwrapper) {
      var btn = document.createElement("button")
      btn.type = "button"; btn.id = "btn"; btn.innerText="タイトルをコピー.";
      document.querySelector("#top_wrapper [class]").append(btn)

      var cpscpt = document.createElement("script")
      cpscpt.innerHTML = document.getElementById('btn').addEventListener('click', async () => {
        await navigator.clipboard.writeText(topwrapper.innerText)
        window.alert('クリップボードにコピーしました。')
      });
      document.append(cpscpt)
    }
  }, false)
})();
