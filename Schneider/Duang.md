### react-native 爬坑

1. 弃用Navigator，使用 [react-navigator](https://reactnavigation.org/docs/intro/quick-start)

   1. Navigator被分离出react-native之后，就没有再更新，不支持prop-types分离了react版本（>16）

   2. 使用方法 

      ```
      const FirstApp = StackNavigator({
      	Main: {
      		screen: Main,
      	},
      })

      export default FirstApp;
      ```

2. ios访问https

   1. [App Transport Security (ATS)](https://segmentfault.com/a/1190000002933776)

3. 分平台

   1. React.Platform

      ```
      var { Platform } = React;

      属性Platform.OS
      showMessage() {
        if(Platform.OS === 'ios') {
          //显示一个简单的提示框
        }else{
          //显示自定义的android snackbar模块
        }
      }
      方法Platform.select
      Platform.select({
        ios:{
          backgroundColor:'red',
        },
        android:{
          backgroundColor:'blue',
        }
      })

      ```

4. 计时器

   1. ```
      _timer: Timer;

        constructor(props) {
          super(props);
          this.state = {
            animating: true,
          };
        }

        componentDidMount() {
          this.setToggleTimeout();
        }

        componentWillUnmount() {
          /* $FlowFixMe(>=0.63.0 site=react_native_fb) This comment suppresses an
           * error found when Flow v0.63 was deployed. To see the error delete this
           * comment and run Flow. */
          clearTimeout(this._timer);
        }

        setToggleTimeout() {
          /* $FlowFixMe(>=0.63.0 site=react_native_fb) This comment suppresses an
           * error found when Flow v0.63 was deployed. To see the error delete this
           * comment and run Flow. */
          this._timer = setTimeout(() => {
            this.setState({animating: !this.state.animating});
            this.setToggleTimeout();
          }, 2000);
        }
      ```

   2. 用于动画的渐变

      ```js
      componentDidMount() {
          Animated.timing(       // Uses easing functions
            this.state.fadeAnim, // The value to drive
            {
              toValue: 1,        // Target
              duration: 2000,    // Configuration
            },
          ).start();             // Don't forget start!
        }
      ```


5. 回调函数

   1. 参数是什么，怎么才能得知

      ```js
      navigator.geolocation.getCurrentPosition(
            (position) => {
              var initialPosition = JSON.stringify(position);
              this.setState({initialPosition});
            },
            (error) => alert(JSON.stringify(error)),
            {enableHighAccuracy: true, timeout: 20000, maximumAge: 1000}
          );
      ```

6. 数据处理

   1. json

      ```
      state = {
      	views: [],
      };
      _onPressAddView = () => {
      	this.setState((state) => ({views: [...state.views, {}]}));
      };
      _onPressRemoveView = () => {
      	this.setState((state) => ({views: state.views.slice(0, -1)}));
      };
      ```

      ​