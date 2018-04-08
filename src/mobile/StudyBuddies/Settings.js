'use strict';

import React, { Component } from 'react';

import {
  StackNavigator, 
} from 'react-navigation';

import {

  StyleSheet,
  Text,
  TextInput,
  View,
  Button,
  ActivityIndicator,
  Image,
} from 'react-native';

export default class Settings extends Component<{}> {

  constructor(){
    super()
    this.state = {
      classes : ["COS333", "COS 445"],
      notifications: true, /* comes from db */
      all_courses: ["SOC 250", "ANT 225", "ENG 201", "ENG 362", "COS 333", "COS 445"]
    }
  }
  render() {

    return (
      <View style={styles.container}>

        <Text style={styles.description}>
          Settings
        </Text>

        <Text style={styles.description}>
          Current Courses:
        </Text>

        <View style={styles.inputBoxes}>

        { 
          this.state.classes.map((item, i) => (

          <View style={{flexDirection: 'row'}}>

          <Text key={i} style={styles.description}> {item} </Text>

          <Button
            onPress={() => this._handlePress()} 
            title = "Del">
          </Button> 

          </View>
          
        ))}

        <Text style={styles.description}>
          Add Courses:
        </Text>

        <Picker
        selectedValue
        >
        </Picker>

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
  flexDirection: 'column',
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
