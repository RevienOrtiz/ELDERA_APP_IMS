<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    public function up(): void
    {
        DB::unprepared('DROP TRIGGER IF EXISTS sync_monthly_income_after_senior_update');
    }

    public function down(): void
    {
        DB::unprepared('CREATE TRIGGER sync_monthly_income_after_senior_update AFTER UPDATE ON seniors FOR EACH ROW BEGIN IF NEW.monthly_income != OLD.monthly_income THEN UPDATE pension_applications SET monthly_income = NEW.monthly_income WHERE senior_id = NEW.id; END IF; END');
    }
};

