#!/usr/bin/python
#Need to install requests package for python
#easy_install requests
import sys
import argparse
import requests
import json

verbose=0

def create_incident(base_url, user, pwd, msg):

	global verbose

	url = base_url + '/api/now/table/sys_user?sysparm_query=user_name%3D' + user + '&sysparm_limit=1'
	# Set proper headers
	headers = {"Content-Type":"application/json","Accept":"application/json"}

	# Do the HTTP request
	response = requests.get(url, auth=(user, pwd), headers=headers)
	# Check for HTTP codes other than 200
	if response.status_code != 200: 
		print('Status:', response.status_code, 'Headers:', response.headers, 'Error Response:',response.json())
		exit(1)
	
	# Decode the JSON response into a dictionary and use the data
	data = response.json()

	if verbose > 0:
		print json.dumps(data)


	if len(response.json()['result']) == 0:
		print "User " + user + " not found"
		exit(1)

	caller = response.json()['result'][0]['sys_id']

	url = base_url + '/api/now/table/incident?sysparm_limit=1'
	# Set proper headers
	create_data = '{\"short_description\":\"Creation of incident ' + msg + '\",\"caller_id\":\"'+ caller + '\"}'
	# Do the HTTP request
	response = requests.post(url, auth=(user, pwd), headers=headers ,data=create_data)

   # Check for HTTP codes other than 201
	if response.status_code != 201: 
		print('Status:', response.status_code, 'Headers:', response.headers, 'Error Response:',response.json())
		exit(1)

	# Decode the JSON response into a dictionary and use the data
	data = response.json()

	if verbose > 0:
		print json.dumps(data)

	print (response.json()['result']['number'])
	print (response.json()['result']['sys_id'])

	return 0

def read_incident(base_url, user, pwd, incident_num):

	global verbose

	url = base_url + '/api/now/table/incident?sysparm_query=GOTOnumber%3D' + incident_num + '&sysparm_limit=1'
	# Set proper headers
	headers = {"Content-Type":"application/json","Accept":"application/json"}

	# Do the HTTP request
	response = requests.get(url, auth=(user, pwd), headers=headers )

   	# Check for HTTP codes other than 201
	if response.status_code != 200: 
		print('Status:', response.status_code, 'Headers:', response.headers, 'Error Response:',response.json())
		exit(1)

	# Decode the JSON response into a dictionary and use the data
	data = response.json()

	if verbose > 0:
		print json.dumps(data)

	if len(response.json()['result']) == 0:
		print "Incident " + incident_num + " not found"
		exit(1)

	print (response.json()['result'][0]['sys_id'])

	return 0

def close_incident(base_url, user, pwd, incident_id,msg):

	global verbose

	url = base_url + '/api/now/table/incident/' + incident_id 
	# Set proper headers
	headers = {"Content-Type":"application/json","Accept":"application/json"}

	# close_data = '{\"state\":\"7\",\"close_notes\":\"Closing incident ' + msg + '\",\"caller_id\":\"240f5f04db202300db5f5385ca96197e\", \"close_code\": \"Closed/Resolved by Caller\"}'
	close_data = '{\"state\":\"7\",\"close_notes\":\"Closing incident ' + msg + '\",\"close_code\": \"Closed/Resolved by Caller\"}'

	# Do the HTTP request
	response = requests.put(url, auth=(user, pwd), headers=headers ,data=close_data)

   	# Check for HTTP codes other than 201
	if response.status_code != 200: 
		print('Status:', response.status_code, 'Headers:', response.headers, 'Error Response:',response.json())
		exit(1)

	# Decode the JSON response into a dictionary and use the data
	data = response.json()

	if verbose > 0:
		print json.dumps(data)

	return 0

def update_incident(base_url, user, pwd, incident_id,msg):

	global verbose

	url = base_url + '/api/now/table/incident/' + incident_id 
	# Set proper headers
	headers = {"Content-Type":"application/json","Accept":"application/json"}

	update_data = '{\"work_notes\":\"Updates ' + msg + '\"}'

	# Do the HTTP request
	response = requests.put(url, auth=(user, pwd), headers=headers ,data=update_data)

   	# Check for HTTP codes other than 201
	if response.status_code != 200: 
		print('Status:', response.status_code, 'Headers:', response.headers, 'Error Response:',response.json())
		exit(1)

	# Decode the JSON response into a dictionary and use the data
	data = response.json()

	if verbose > 0:
		print json.dumps(data)

	return 0

def main():

    # Process Command Line Parameters
    parser = argparse.ArgumentParser(
             description='Create, read, update or close an incident in ServiceNow. ',
             epilog='')
    parser.add_argument("-b", "--sn_base_url", dest="sn_base_url", required=True)
    parser.add_argument("-u", "--sn_user", dest="sn_user", required=True)
    parser.add_argument("-p", "--sn_pass", dest="sn_pass", required=True)
    parser.add_argument("-i", "--sn_incident_id", dest="sn_incident_id", required=False)
    parser.add_argument("-n", "--sn_incident_num", dest="sn_incident_num", required=False)
    parser.add_argument("-m", "--cmd_msg", dest="cmd_msg", default='from CAM adapter for Service Now', required=False)
    parser.add_argument("-v", "--verbose", dest="verbose", required=False)

    # -c to add -d to delete
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('-c', '--create', default=False, action='store_true')
    group.add_argument('-r', '--read', default=False, action='store_true')
    group.add_argument('-t', '--update', default=False, action='store_true')
    group.add_argument('-d', '--close', default=False, action='store_true')    

    args = parser.parse_args()

    sn_base_url = args.sn_base_url
    sn_user = args.sn_user
    sn_pass = args.sn_pass

    if (args.verbose is not None):
		global verbose
		verbose=int(args.verbose)
		print 'verbose: ', verbose

    #if not cmdb_server.list({'name': args.cmdb_key}):
    #  sys.stderr.write('cmdb_server: Error Connecting to CMDB.')
    #  exit(1)

    # Process Request
    if args.create:

        print 'Create incident in ServiceNow ....'
        print 'SN Base Url: ' + args.sn_base_url
        print 'SN User: ' + args.sn_user
        print 'SN Pass: ' + '*****'

        response = create_incident(sn_base_url, sn_user, sn_pass, args.cmd_msg)

    elif args.read:

    	if args.sn_incident_num is None:
    		print 'Missing sn_incident_num argument'
    		exit(1)

    	print 'Read incident ' + args.sn_incident_num + ' in ServiceNow ....'
        print 'SN Base Url: ' + args.sn_base_url
        print 'SN User: ' + args.sn_user
        print 'SN Pass: ' + '*****'

        response = read_incident(sn_base_url, sn_user, sn_pass, args.sn_incident_num )

    elif args.close:

       	if args.sn_incident_id is None:
    		print 'Missing sn_incident_id argument'
    		exit(1)

    	print 'Close incident with id: ' + args.sn_incident_id + ' in ServiceNow ....'
        print 'SN Base Url: ' + args.sn_base_url
        print 'SN User: ' + args.sn_user
        print 'SN Pass: ' + '*****'

        response = close_incident(sn_base_url, sn_user, sn_pass, args.sn_incident_id, args.cmd_msg)

    elif args.update:

    	if args.sn_incident_id is None:
    		print 'Missing sn_incident_id argument'
    		exit(1)

    	print 'Close incident with id: ' + args.sn_incident_id + ' in ServiceNow ....'
        print 'SN Base Url: ' + args.sn_base_url
        print 'SN User: ' + args.sn_user
        print 'SN Pass: ' + '*****'

        response = update_incident(sn_base_url, sn_user, sn_pass, args.sn_incident_id, args.cmd_msg)


    if response:
        exit(0)
    else:
        exit(1)

if __name__ == "__main__":
    main()

