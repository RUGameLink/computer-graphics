var Main = function() {
    function Main() {
        this.vars();
        this.launchTrains();
        this.animate();
    }

    Main.prototype.vars = function() {
        var cabin, i, _i, _j;
        this.train1 = {
            cabins: [],
            path: document.getElementById('bluepathjs')
        };
        for (i = _i = 1; _i <= 3; i = ++_i) {
            if (cabin = document.getElementById("bluecabin" + i)) {
                this.train1.cabins.push(cabin);
            }
        }
        this.cabinWidth = 2.5 * this.train1.cabins[0].getBoundingClientRect().width;
        this.childNode = this.isIE() ? 1 : 0;
        this.childMethod= this.isIE() ? 'childNodes' : 'children';
        return this.animate = this.bind(this.animate, this);
    };
    
    Main.prototype.launchTrains = function() {
        var it;
        it = this;
        this.train1Tween = new TWEEN.Tween({length: this.train1.path.getTotalLength()})
        .to({length: 0}, 8000).onUpdate(function() {
            var angle, attr, cabin, cabinChild, i, point, prevPoint, shift, x, x1, x2, y, _i, _len, _ref, _results;
            _ref = it.train1.cabins;_results = [];
            for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
                cabin = _ref[i];
                shift = i * it.cabinWidth;
                point = it.train1.path.getPointAtLength(this.length -shift);
                prevPoint =it.train1.path.getPointAtLength(this.length -shift -1);
                x1 = point.y -prevPoint.y;
                x2 = point.x -prevPoint.x;angle = Math.atan(x1 / x2) * (180 / Math.PI);
                x = point.x;
                y = point.y -20;
                if (point.x -prevPoint.x > 0) {
                    if (!cabin.isRotated) {
                        cabinChild = cabin[it.childMethod][it.childNode];
                        cabinChild.setAttribute('xlink:href', '#cabin2');
                        cabin.isRotated = true;
                    }
                } else {
                    if (cabin.isRotated) {
                        cabinChild = cabin[it.childMethod][it.childNode];
                        cabinChild.setAttribute('xlink:href', '#cabin1');
                        cabin.isRotated = false;
                    }
                }
                attr = "translate(" + x + ", " + y + ") rotate(" + (angle || 0) + ",0,0) scale(-0.25,0.25)";
                _results.push(cabin.setAttribute('transform', attr));
            }
            return _results;
        }).repeat(999999999999).start();
    };

    Main.prototype.animate = function() {
        requestAnimationFrame(this.animate);
        return TWEEN.update();
    };

    Main.prototype.isIE = function() {
        var msie, rv, rvNum, trident, ua, undef;
        if (this.isIECache) {
            return this.isIECache;
        }
        undef = void 0;
        rv = -1;
        ua = window.navigator.userAgent;
        msie = ua.indexOf("MSIE ");
        trident = ua.indexOf("Trident/");
        if (msie > 0) {
            rv = parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)), 10);
        } else if (trident > 0) {
            rvNum = ua.indexOf("rv:");
            rv = parseInt(ua.substring(rvNum + 3, ua.indexOf(".", rvNum)), 10);
        }
        this.isIECache = (rv > -1 ? rv : undef);
        return this.isIECache;
    };

    Main.prototype.bind = function(func, context) {
        var bindArgs, wrapper;
        wrapper = function() {
            var args, unshiftArgs;
            args = Array.prototype.slice.call(arguments);
            unshiftArgs = bindArgs.concat(args);
            return func.apply(context, unshiftArgs);
        };
        bindArgs = Array.prototype.slice.call(arguments, 2);
        return wrapper;
    };

    new Main();
}
