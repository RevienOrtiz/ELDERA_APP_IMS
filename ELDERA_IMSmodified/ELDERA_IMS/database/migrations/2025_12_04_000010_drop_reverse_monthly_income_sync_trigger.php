<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    public function up(): void
    {
        DB::unprepared('DROP TRIGGER IF EXISTS sync_monthly_income_after_pension_update');
    }

    public function down(): void
    {
        DB::unprepared('CREATE TRIGGER sync_monthly_income_after_pension_update AFTER UPDATE ON pension_applications FOR EACH ROW BEGIN IF OLD.monthly_income <> NEW.monthly_income THEN UPDATE seniors SET monthly_income = NEW.monthly_income WHERE id = NEW.senior_id; END IF; END');
    }
};

