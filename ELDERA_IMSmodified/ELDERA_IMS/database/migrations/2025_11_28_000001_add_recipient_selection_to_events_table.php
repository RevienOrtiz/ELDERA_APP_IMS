<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::connection('eldera_ims')->table('events', function (Blueprint $table) {
            $table->text('recipient_selection')->nullable()->after('requirements');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::connection('eldera_ims')->table('events', function (Blueprint $table) {
            $table->dropColumn('recipient_selection');
        });
    }
};
