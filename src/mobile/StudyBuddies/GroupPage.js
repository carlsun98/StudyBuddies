  /* Page user sees after tapping on a class they are currently following.
   * Allows user to redirect to map to see where current groups are, as
   * well as create a group.
   * TODO: -styling
   *       -Link to server so email sends and redirects
   *********************************************************************/

  'use strict';

/*
 to do :
 figure out how to read and display the time left
 figure out the API for it
 How do we change the leader?
*/
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
  import {
    StackNavigator,
    NavigationActions
  } from 'react-navigation';
  import Moment from 'react-moment';
  import moment from 'moment'
  import styles from './stylings';
  import Settings from './Settings';
  import NewGroupC from './NewGroupC'

var now = moment();
// GET THIS FROM DATABASE
var nextTime = now.add(2, 'hours')

  export default class GroupPage extends Component<{}> {
      constructor(){
  	super()
  	this.state = {
  	    group_class_id: "COS333",
        group_end_hours: "17",
      //  group_end_minutes: "30",
       group_location: "Frist",
        group_category: "PSet",
        group_desc: "Cool Kids",
      }
    }
      _handleChangeGInfoPress() {
        this.props.navigation.navigate('NewGroupC')
        console.log("LOG"+now.format())
        console.log(nextTime.format())
      }
      _handleLeaveGPress() {
        this.props.navigation.dispatch(NavigationActions.back());
      }
      // something should change in the API here
      _handleDeleteGPress() {
        this.props.navigation.dispatch(NavigationActions.back());
      }

      render() {
  	return (
  	 <View style={styles.container}>
     <View>
  	<Text style={styles.description}>
      Class Studied: {this.state.group_class_id}
    </Text>

    <Text style={styles.description}>
    // Why isn't .diff working?
    You have a total of {nextTime.diff(now, 'hours')} hours and {nextTime.diff(now, 'minutes')} minutes
  	</Text>

     <Text style={styles.description}>
      Location: {this.state.group_location}
      </Text>

     <Text style={styles.description}>
      Category: {this.state.group_category}
      </Text>

      <Text style={styles.description}>
      Description: {this.state.group_desc}
      </Text>

  	 </View>

  	  <View style={styles.buttons}>
      <Button
        onPress={() => this._handleChangeGInfoPress()}
        title = "Change Time or Description">
      </Button>

      <Button
        onPress={() => this._handleLeaveGPress()}
        title = "Leave Group">
      </Button>

      <Button
        onPress={() => this._handleDeleteGPress()}
        title = "Delete Group">
      </Button>

  	    </View>
        </View>
  	);
      }
  }
