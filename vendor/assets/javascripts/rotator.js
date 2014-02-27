var Rotator = (function () {
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

  function extend(target, obj) {
    for (prop in obj) {
      if (obj.hasOwnProperty(prop)) {
        if (prop == 'grid') {
          if (!target[prop]) target[prop] = {};
          extend(target[prop], obj[prop]);
        } else {
          target[prop] = obj[prop];
        }
      }
    }
  }

  var Rotator = new Class({
    init: function (user_config) {
      this.configurate(user_config);

      this.img = new Image();

      var self = this;

      this.img.onload = function() {
        self.width = this.width;
        self.height = this.height;

        self.make();
      };

      this.img.src = this.src;
    },

    configurate: function (user_config) {
      var default_config = {
        angle: 0,

        grid: {
          visibility: false,
          width: 1,
          color: '#5aa',
          step: 40
        },

        load: function () {},
        change: function () {}
      };

      config = {};

      extend(config, default_config);
      extend(config, user_config);

      for (prop in config) {
        if (config.hasOwnProperty(prop)) {
          this[prop] = config[prop];
        }
      }
    },

    make: function () {
      this.size = Math.round(Math.sqrt(this.width * this.width + this.height * this.height));

      this.container.innerHTML = '<canvas width="' + this.size + '" height="' + this.size + '"></canvas>';
      this.canvas = this.container.children[0];
      this.ctx = this.canvas.getContext('2d');

      this.container.style.position = 'relative';
      this.container.style.width = this.size + 'px';
      this.container.style.height = this.size + 'px';
      this.container.style.cursor = 'crosshair';

      this.canvas.style.position = 'absolute';
      this.canvas.style.left = '0px';
      this.canvas.style.right = '0px';
      this.canvas.style.cursor = 'crosshair';

      this.load(this);
      this.rotate(this.angle);
    },

    rotate: function (angle) {
      this.angle = angle;
      this.redraw();
      this.change(this);
    },

    redraw: function () {
      this.clear();
      this.drawImage();
      this.drawGrid();
    },

    clear: function () {
      this.ctx.clearRect(0, 0, this.size, this.size);
      this.ctx.save();
    },

    drawImage: function () {
      var rad = this.angle * Math.PI / 180;

      this.ctx.translate(this.size / 2, this.size / 2);
      this.ctx.rotate(rad);
      this.ctx.drawImage(this.img, - this.width / 2, - this.height / 2, this.width, this.height);
      this.ctx.restore();
    },

    drawGrid: function () {
      if (!this.grid.visibility) return;

      this.ctx.lineWidth = this.grid.width;
      this.ctx.strokeStyle = this.grid.color;

      this.ctx.beginPath();

      var half = Math.round(this.size / 2);
      var fix = this.grid.width % 2 == 0 ? 0 : 0.5;

      for (var offset = 0; offset <= half; offset += this.grid.step)
      {
        var offsets = offset == 0 ? [offset] : [-offset, offset];

        for (i in offsets) {
          if (offsets.hasOwnProperty(i)) {
            this.ctx.moveTo(half + offsets[i] + fix, 0);
            this.ctx.lineTo(half + offsets[i] + fix, this.size);
            this.ctx.moveTo(0, half + offsets[i] + fix);
            this.ctx.lineTo(this.size, half + offsets[i] + fix);
          }
        }
      }

      this.ctx.stroke();

      this.ctx.closePath();
    }
  });

  return Rotator;
})();

