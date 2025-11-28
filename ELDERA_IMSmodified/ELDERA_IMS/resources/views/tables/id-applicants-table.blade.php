<!-- Senior ID Applicants Table -->
<div class="table-container" id="id-applicants-table" style="display: none;">
    <table class="records-table">
        <thead style="position: sticky; top: 0; z-index: 1; background-color: #f8f9fa;">
            <tr>
                <th>NO.</th>
                <th>OSCA ID NO.</th>
                <th>FULL NAME</th>
                <th>AGE</th>
                <th>Gender</th>
                <th>BARANGAY</th>
                <th>STATUS</th>
                <th>ACTION</th>
            </tr>
        </thead>
        <tbody>
            @forelse($idApplications as $index => $application)
            <tr>
                <td>{{ $index + 1 }}</td>
                <td>{{ $application->senior ? $application->senior->osca_id : 'N/A' }}</td>
                <td>
                    @if($application->senior)
                        {{ ucfirst($application->senior->last_name) }}, {{ ucfirst($application->senior->first_name) }}
                        {{ $application->senior->middle_name ? ' ' . ucfirst($application->senior->middle_name) : '' }}
                        {{ $application->senior->name_extension ? ' ' . ucfirst($application->senior->name_extension) : '' }}
                    @else
                        N/A
                    @endif
                </td>
                <td>{{ $application->senior && $application->senior->date_of_birth ? \Carbon\Carbon::parse($application->senior->date_of_birth)->age : 'N/A' }}</td>
                <td>{{ $application->senior ? ucfirst($application->senior->sex) : 'N/A' }}</td>
                <td>{{ $application->senior ? implode('-', array_map('ucfirst', explode('-', $application->senior->barangay))) : 'N/A' }}</td>
                <td>
                    <span class="status-badge status-{{ strtolower($application->status) }}">
                        {{ ucfirst(str_replace('_', ' ', $application->status)) }}
                    </span>
                </td>
                <td>
                    <div class="action-buttons">
                        <a href="{{ route('seniors.id-application.view', $application->id) }}" class="btn btn-sm btn-primary">
                            <i class="fas fa-eye"></i> View
                        </a>
                        <a href="{{ route('seniors.id-application.edit', $application->id) }}" class="btn btn-sm btn-warning">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <button class="btn btn-sm btn-danger" onclick="showDeleteModal('{{ $application->id }}', '{{ $application->senior ? ($application->senior->last_name . ', ' . $application->senior->first_name . ($application->senior->middle_name ? ' ' . $application->senior->middle_name : '') . ($application->senior->name_extension ? ' ' . $application->senior->name_extension : '')) : 'N/A' }}', 'id')">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </div>
                </td>
            </tr>
            @empty
            <tr>
                <td colspan="8" class="text-center">No ID applications found</td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>
