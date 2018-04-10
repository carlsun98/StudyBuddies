/* Last page of create group flow. Allows user to choose group purpose
 * (General Review, Exam Cramming, or Homework) as well as write a
 * description with any other details they want other users to see
 * when thinking about joining.
 * TODO: -styling
 *       -add purpose options
 *       -link it to store descriptions
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
import GroupPage from './GroupPage'
import styles from './stylings';

export default class NewGroupD extends Component<{}> {
    constructor(){
	super()
	this.state = {
            groupCategory: '',
            groupDesc: '',
	}
    }
    _handlePress() {
	console.log(this.state.groupCategory);
    console.log(this.state.groupDesc);
	this.props.navigation.navigate('GroupPage')
    }

render() {
    return (

        <View style={styles.container}>

        <Text style={styles.description}>
        You Are Making a New Group!
            </Text>


        <View style={{flexDirection: 'row'}}>
            <Text style={styles.description}>
        Purpose of Group:
            </Text>

        <TextInput 
            style={styles.searchInput}
            placeholder='     '
            returnKeyType = {"next"}
        onChangeText={(text) => this.setState({groupCategory:text})}
            />
            </View>

        <View style={{flexDirection: 'row'}}>
            <Text style={styles.description}>
        Description:
            </Text>

        <TextInput 
            style={styles.searchInput}
            placeholder='     '
            returnKeyType = {"next"}
        onChangeText={(text) => this.setState({groupDesc:text})}
            />
            </View>

        <View style={styles.buttons}>
        <Button
        onPress={() => this._handlePress()}
	color = '#1E1E46'
            title = "Done">
        </Button>
        </View>

        </View>
    );
    }
}
