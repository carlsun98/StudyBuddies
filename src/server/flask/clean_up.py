from dbconnect import connect

'''
Clean up API @ /clean_up
Input:
    None
Output:
    None
'''
cursor, conn = connect()
clean_up_stmt = "DELETE FROM groups WHERE end_time < CURRENT_TIMESTAMP"
cursor.execute(clean_up_stmt)
