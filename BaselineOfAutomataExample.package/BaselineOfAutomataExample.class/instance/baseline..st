api projectSpec
baseline: spec
   <baseline>
	spec for: #'common' do: [
		
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
				
			project: 'Seaside3' with: [
				spec
					className: #ConfigurationOfSeaside3;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main/';
					loads: #(default REST) ];
			project: 'RESTAnnouncer' with: [
				spec
					className: #BaselineOfRESTAnnouncer;
					repository: 'github://mikefilonov/restannouncer:master' ].
		
		spec package: #'Automata-Example-ToDo'. ].
