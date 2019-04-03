<talk-app>
  <input type="text" ref="userInput" placeholder="Name the pet">
  <input type="text" ref="msgInput" placeholder="Type in your message" value="">
	<button type="button" onclick={ saveMsg }>Teach the pet to talk</button>

  <div class="talk-list">
    	<talk-item each={ msg in messages }></talk-item>
  </div>

	<script>

    var tag = this;
    var messagesRef = rootRef.child('messages');
    var userRef = rootRef.child('messageByUser');

    this.userID = "Pet";
    this.messages = [];
    this.users = [];

    this.setUser = function(){
      this.userID = this.refs.userInput.value;
    }

    this.saveMsg = function(){
      var key = messagesRef.push().key;
      console.log(key);

      var msg = {
        id: this.refs.userInput.value,
        message:this.refs.msgInput.value
      };



      messagesRef.push(msg);
    }

    messagesRef.on('value', function(snap){
			let dataAsObj = snap.val();


			var tempData = [];

			//instead of statically typing out the array value, we now read it in
			//from the firebase data obj using a js for loop structure
			for (key in dataAsObj) {
				tempData.push(dataAsObj[key]);
			}

			//finally, we copy this array back to our tag's property field
			// console.log("myMemes", tag.myMemes);
			tag.messages = tempData;

			//same question, 4th time of encounter. Why do we need to call tag update here?
			tag.update();
		});


	</script>

	<style>
		:scope {
			display:  block;
      margin:auto;
			height: 10%;
			width: 100%;
      padding:20px;
      text-align: center;
		}

    button{
      text-align: left;
    }

		.talk-list {
			margin-top: 20px;
		}
	</style>

</talk-app>
