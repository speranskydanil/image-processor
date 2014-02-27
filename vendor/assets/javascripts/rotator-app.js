var RotatorApp = (function () {
  function Class(conf) {
    var init = conf.init || function () {};
    delete conf.init;

    var parent = conf.parent || function () {};
    delete conf.parent;

    var F = function () {};
    F.prototype = parent.prototype;
    var f = new F();
    for (var fn in conf) f[fn] = conf[fn];
    init.prototype = f;

    return init;
  };

  var RotatorApp = new Class({
    init: function (config) {
      this.buildCanvas(config);
      this.buildToolbar(config);
    },

    buildCanvas: function (config) {
      config.container = $(config.container).get(0);
      this.rotator = new Rotator(config);
    },

    buildToolbar: function (config) {
      this.createToolbarDom(config);
      this.bindToolbarEvents();
    },

    createToolbarDom: function (config) {
      this.toolbar = $(config.toolbar).addClass('rotator-app-toolbar').html('');

      this.controller = $('<div class="rotator-app-controller">').appendTo(this.toolbar);

      this.minus = $('<a class="rotator-app-minus" href="#">−</a>').button().appendTo(this.controller);
      this.angle = $('<input class="rotator-app-angle" type="text">').val(this.rotator.angle).appendTo(this.controller);
      this.plus = $('<a class="rotator-app-plus" href="#">+</a>').button().appendTo(this.controller);

      this.controller.append('&nbsp;°&nbsp;');

      this.rotate_btn = $('<a class="rotator-app-rotate-btn" href="#">Rotate</a>').appendTo(this.controller);

      this.slider = $('<div class="rotator-app-slider">').appendTo(this.toolbar);

      this.toolbar.append('<div style="clear: both;">');

      this.slider.slider({ value: this.rotator.angle, min: -90, max: 90, step: 0.1 });
    },

    bindToolbarEvents: function () {
      var self = this;

      this.angle.change(function() {
        self.rotate(parseFloat(self.angle.val()));
      });

      this.rotate_btn.click(function(e) {
        e.preventDefault();
        self.rotate(parseFloat(self.angle.val()));
      });

      this.minus.click(function(e) {
        e.preventDefault();
        self.rotate((parseFloat(self.angle.val()) - 0.1).toFixed(1));
      });

      this.plus.click(function(e) {
        e.preventDefault();
        self.rotate((parseFloat(self.angle.val()) + 0.1).toFixed(1));
      });

      this.slider.bind('slide', function (event, ui) {
        self.rotate(ui.value);
      });
    },

    rotate: function (angle) {
      this.angle.val(angle);
      this.slider.slider('value', angle);
      this.rotator.rotate(angle);
    }
  });

  return RotatorApp;
})();

