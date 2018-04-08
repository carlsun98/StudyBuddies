'use strict';

import React, { Component } from 'react';
import {

  StyleSheet,
  Text,
  TextInput,
  View,
  Button,
  ActivityIndicator,
  Image,
} from 'react-native';
import AwaitingConfirmation from './AwaitingConfirmation';

export default class CreateUser extends Component<{}> {
	constructor(){
    super()

    this.state = {
      username: '',
      password: '',
    }
  }
    _handlePress() {
     console.log(this.state.username);
     console.log(this.state.password);
     this.props.navigation.navigate('AwaitingConfirmation', {email: this.state.username})
  }

  render() {
    return (
      <View style={styles.container}>

        <Text style={styles.description}>
          Welcome to StudyBuddy! You will be studying in no time!
        </Text>

        <Text style={styles.description}>
        	First, we need your school email and a password for you. Then we will send you a confirmation
          email with a link to click, and you will be all set!
        </Text>

       <View style={styles.inputBoxes}>

        <View style={{flexDirection: 'row'}}>

          <Text>
            Email:
          </Text>

  		    <TextInput 
    	     style={styles.searchInput}
           placeholder = "    "
    	     returnKeyType = {"next"}
 		     onChangeText={(text) => this.setState({username:text})}
    	     />
        </View>

        <View style={{flexDirection: 'row'}}>
          <Text>
            Create Password:
          </Text>

  		    <TextInput 
    	     style={styles.searchInput}
           placeholder = "    "
    	     returnKeyType = {"next"}
 		     onChangeText={(text) => this.setState({password:text})}
    	   />
        </View>

        <View style={{flexDirection: 'row'}}>
          <Text>
            Repeat Password:
          </Text>

          <TextInput 
           style={styles.searchInput}
           placeholder = "    "
           returnKeyType = {"next"}
         onChangeText={(text) => this.setState({password:text})}
         />
        </View>

        <Button
          onPress={() => this._handlePress()} 
          title = "Send Me the Email!">
        </Button>
        
		</View>

    </View>
    );
  }
}

const styles = StyleSheet.create({
  description: {
    marginBottom: 20,
    fontSize: 18,
    textAlign: 'center',
    color: '#656565'
  },

   descriptionAsk: {
    marginBottom: 20,
    fontSize: 18,
    textAlign: 'left',
    color: '#656565'
  },

  container: {
    padding: 30,
    marginTop: 65,
    flex: 1
  },
  inputBoxes: {
  alignItems: 'center',
  padding: 10
},
searchInput: {
  height: 36,
  padding: 4,
  marginRight: 5,
  marginLeft: 5,
  fontSize: 18,
  borderWidth: 1,
  borderColor: '#48BBEC',
  borderRadius: 8,
  color: '#48BBEC',
},
});
