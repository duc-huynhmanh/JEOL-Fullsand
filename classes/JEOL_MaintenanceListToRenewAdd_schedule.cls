global class JEOL_MaintenanceListToRenewAdd_schedule implements Schedulable {

   global void execute(SchedulableContext SC) {

        Datetime sysTime = System.now();
        System.scheduleBatch(new JEOL_MaintenanceListToRenewAdd_batch(), 'MaintenanceJobBatch' + sysTime, 0);

	}

}