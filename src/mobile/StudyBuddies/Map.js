/* First page of create group flow. Asks for course user wants to
 * make the group for.
 * TODO: -styling
 *       -link it to school's courses
 *******************************************************************/

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
import styles from './stylings';

export default class Map extends Component<{}> {
    constructor(){
	super()
	this.state = {
            groupClass: '',
	}
    }
    _handlePress() {
	console.log(this.state.groupClass);
	this.props.navigation.navigate('NewGroupB')
    }

    render() {
	return (
              <View style={styles.container}>
		<Text style={styles.description}>
		  Map goes here
                </Text>
	      </View>
	);
    }
}
