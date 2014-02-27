(function ($) {
  $.url = function (url) {
    return {
      url: url,

      set: function (name, value) {
        this.unset(name);
        this.url += (this.url.indexOf('?') > -1 ? '&' : '?') + name + '=' + value;
        
        return this;
      },

      unset: function (name) {
        this.url = this.url
          .replace(new RegExp('([?&])' + name + '=[^&]*', 'g'), '$1')
          .replace(/\?&/g, '?')
          .replace(/&&/g, '&')
          .replace(/[?&]$/, '');

        return this;
      },

      toString: function () {
        return this.url;
      }
    };
  };
})(jQuery);

